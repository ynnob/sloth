import 'package:sloth/sloth.dart';

void main() {
  /////////////////////////////////
  // sloth_datetime extensions
  /////////////////////////////////

  // get secondsSinceEpoch
  int seconds = DateTime.now().secondsSinceEpoch;
  print("Seconds since epoch $seconds s");
}
