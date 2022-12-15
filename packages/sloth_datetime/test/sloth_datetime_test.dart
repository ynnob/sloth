import 'package:sloth_datetime/sloth_datetime.dart';
import 'package:test/test.dart';

void main() {
  group('DateTime Extension Test', () {
    test('Test secondsSinceEpoch', () {
      int millisecondsSinceEpoch = DateTime.now().millisecondsSinceEpoch;
      int secondsSinceEpoch = DateTime.now().secondsSinceEpoch;

      expect(secondsSinceEpoch, (millisecondsSinceEpoch / 1000).round());
    });
  });
}
