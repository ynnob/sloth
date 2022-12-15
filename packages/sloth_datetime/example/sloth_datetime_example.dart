import 'package:sloth_datetime/sloth_datetime.dart';

void main() {
  // get secondsSinceEpoch
  int seconds = DateTime.now().secondsSinceEpoch;
  print("Seconds since epoch $seconds s");
}
