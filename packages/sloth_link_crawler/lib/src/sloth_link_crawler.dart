import 'dart:async';
import 'dart:developer';

import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:queue/queue.dart';
import 'package:robots_txt/robots_txt.dart';

import '../extensions/crawler_interceptor.dart';
import '../extensions/crawler_retry_policy.dart';

class SlothLinkCrawler {
  String baseUrl;
  bool onlyInternalDomainLinks;
  List<String> lUrl = List.empty(growable: true);
  late Queue queue;
  Robots? robots;
  bool debugMode;
  Duration? duration;
  String userAgent;

  SlothLinkCrawler(
      {required this.baseUrl,
      this.onlyInternalDomainLinks = false,
      this.duration,
      this.debugMode = false,
      this.userAgent = '*'}) {
    queue = Queue(delay: duration);
  }

  Future<List<String>> crawl() async {
    lUrl = List.empty(growable: true);
    robots = await _loadRobotsSettings();

    baseUrl = _cleanUpLink(baseUrl);

    // add base url to discovery list
    lUrl.add(baseUrl);

    await queue.add(() async => await scan(baseUrl));
    await queue.onComplete;

    // print result if debug enabled
    if (debugMode) {
      print("Discovered URL's:");
      var c = 0;
      for (final element in lUrl) {
        c++;
        debug('[$c] $element');
      }
    }

    return lUrl;
  }

  Future<void> scan(String target) async {
    try {
      final targetUri = Uri.parse(target);
      final client = InterceptedClient.build(
          interceptors: [CrawlerInterceptor(userAgent)],
          retryPolicy: CrawlerRetryPoliciy());
      final response = await client.get(targetUri);
      debug('SCAN $target');

      // Check that we are allowed to crawl this page
      if (robots != null) {
        if (robots!.canVisitPath(target, userAgent: userAgent) == false) {
          return;
        }
      }

      // ignore: prefer_final_locals
      var lFoundUrls = List<String>.empty(growable: true);

      //If the http request is successful the statusCode will be 200
      if (response.statusCode == 200) {
        if (response.body != '') {
          final bs = BeautifulSoup(response.body);
          final elements = bs.findAll('a');
          for (final element in elements) {
            if (element.hasAttr('href')) {
              final value = element.getAttrValue('href');
              if (value != null && value.isNotEmpty) {
                // we are only interested in links of the base domain
                var elementUrl = Uri.parse(value);

                if (elementUrl.toString().startsWith('http://') ||
                    elementUrl.toString().startsWith('https://') ||
                    elementUrl.isAbsolute) {
                  if (onlyInternalDomainLinks == false) {
                    lFoundUrls.add(elementUrl.toString());
                  } else if (elementUrl.host == targetUri.host) {
                    // this path is on the base domain
                    lFoundUrls.add(elementUrl.toString());
                  }
                } else {
                  // make sure the second part of the url actually starts with /
                  if (elementUrl.toString().startsWith('/') == false) {
                    elementUrl = Uri.parse('/$elementUrl');
                  }

                  // create absolute uri
                  final absUri = Uri.parse(baseUrl + elementUrl.toString());
                  lFoundUrls.add(absUri.toString());
                }
              }
            }
          }
        }
      }

      // if we got urls filter the new urls, add them to the final list and scrape them
      debug('${lFoundUrls.length} links found for $baseUrl');
      var c = 0;
      for (final element in lFoundUrls) {
        // remove trailing /
        final cleanElement = _cleanUpLink(element);

        if (lUrl.contains(cleanElement) == false) {
          if (c == 0) {
            debug('Adding the following links: ');
          }

          lUrl.add(cleanElement);
          c++;
          debug('=> [$c] $cleanElement');
          // even tho we may have all urls we only want to deep search into the same domain
          if (cleanElement.startsWith(getDomainString(baseUrl))) {
            unawaited(queue.add(() => scan(cleanElement)));
          }
        }
      }

      // if c is still 0 we did not add a new link to the list
      if (c == 0) {
        debug('=> All discovered links were already added to the list!');
      }

      debug(' ');
      debug(
          '=================================================================');
      debug(' ');
    } catch (e) {
      debug('Error: ${e.toString()}');
    }
  }

  Future<Robots?> _loadRobotsSettings() async {
    try {
      final uri = getDomainString(baseUrl);
      final robotsInfo = Robots(host: uri);
      await robotsInfo.read();
      return robotsInfo;
    } catch (e) {
      debug(e.toString());
      return null;
    }
  }

  String _cleanUpLink(String src) {
    if (src.endsWith('/')) {
      return src.substring(0, src.toString().length - 1);
    }
    return src;
  }

  String getDomainUri(Uri src) => '${src.scheme}://${src.host}';
  String getDomainString(String src) =>
      '${Uri.parse(src).scheme}://${Uri.parse(src).host}';

  void debug(String msg) {
    if (debugMode) {
      print(msg);
    }
  }
}
