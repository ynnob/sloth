<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# ARE YOU A SLOTH? - SLOTH LINK CRAWLER

This package is WIP!
It will crawl an url and list all links. We try to respect the robots.txt file. See example on how to implement into your codebase.

## Features

- Crawl URL
- List all links (internal OR all)
- Delay crawl requests
- Custom user agent

## Getting started

With dart:
```dart
 $ dart pub add sloth_link_crawler
```

With Flutter:
```dart
 $ flutter pub add sloth_link_crawler
```

## Usage

Import the package

```dart
import 'package:sloth_link_crawler/sloth_link_crawler.dart';
```

Access the extensions:
```dart
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
```


