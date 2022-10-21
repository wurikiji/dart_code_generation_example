// ignore_for_file: unused_import

import 'package:test/test.dart';

import './samples/getter_setter.dart';

Future<void> main() async {
  group('GetterSetter annotation on global context', () {
    test('can generate getter', () {
      expect(getterOnly, 0);
    });

    test('can generate setter', () {
      setterOnly = 1;
    });

    test('can generate both on a same variable', () {
      both = 1;
      expect(both, 1);
      both = 2;
      expect(both, 2);
    });
  });

}
