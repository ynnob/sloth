import 'package:sloth_datetime/sloth_datetime.dart';
import 'package:test/test.dart';

void main() {
  group('DateTime Extension Test', () {
    test('Test secondsSinceEpoch', () {
      final millisecondsSinceEpoch = DateTime.now().millisecondsSinceEpoch;
      final secondsSinceEpoch = DateTime.now().secondsSinceEpoch;

      expect(secondsSinceEpoch, (millisecondsSinceEpoch / 1000).round());
    });
  });
}
