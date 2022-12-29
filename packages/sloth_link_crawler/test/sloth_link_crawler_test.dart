import 'package:sloth_link_crawler/sloth_link_crawler.dart';
import 'package:test/test.dart';

void main() {
  test('Robots.txt allowance test', () async {
    final crawler = SlothLinkCrawler(
        baseUrl: 'https://example.com',
        onlyInternalDomainLinks: true,
        debugMode: true,
        duration: const Duration(seconds: 2),
        userAgent: 'SlothLinkCrawler');
    final result = await crawler.crawl();
    expect(result, isNotNull);
  }, timeout: const Timeout(Duration(minutes: 25)));
}
