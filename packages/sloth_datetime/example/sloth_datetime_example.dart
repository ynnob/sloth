// ignore_for_file: prefer_final_locals, omit_local_variable_types

import 'package:sloth_datetime/sloth_datetime.dart';

void main() {
  // get secondsSinceEpoch
  int seconds = DateTime.now().secondsSinceEpoch;
  print('Seconds since epoch $seconds s');
}
