// ignore_for_file: unused_local_variable, prefer_final_locals, omit_local_variable_types

import 'package:sloth_link_crawler/sloth_link_crawler.dart';

void main() async {
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
