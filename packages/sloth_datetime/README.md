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

# ARE YOU A SLOTH? - SLOTH DATETIME


## Features

- DateTime extension:
    - secondsSinceEpoch

## Getting started

With dart:
```dart
 $ dart pub add sloth_datetime
```

With Flutter:
```dart
 $ flutter pub add sloth_datetime
```

## Usage

Import the package

```dart
import 'package:sloth_datetime/sloth_datetime.dart';
```

Access the extensions:
```dart
  // get secondsSinceEpoch
  int seconds = DateTime.now().secondsSinceEpoch;
  print("Seconds since epoch $seconds s");
```


