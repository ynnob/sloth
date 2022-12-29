// ignore_for_file: prefer_final_locals, omit_local_variable_types, unused_local_variable

import 'package:sloth/sloth.dart';

void main() async {
  /////////////////////////////////
  // sloth_datetime extensions
  /////////////////////////////////

  // get secondsSinceEpoch
  int seconds = DateTime.now().secondsSinceEpoch;
  print('Seconds since epoch $seconds s');

  /////////////////////////////////
  // sloth_link_crawler
  /////////////////////////////////

  final crawler = SlothLinkCrawler(
      // Domain to crawl
      baseUrl: 'https://example.com',
      // if true only urls of the domain will get listed
      onlyInternalDomainLinks: true,
      // if true some debugging information will be displayed in the console
      debugMode: true,
      // set the duration between crawl calls
      duration: const Duration(seconds: 2),
      // set a custom user agent
      userAgent: 'SlothLinkCrawler');

  // List of all crawled urls
  List<String> result = await crawler.crawl();
}
