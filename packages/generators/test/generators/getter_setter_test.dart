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
    test('has no problem with pubilc variables', () {
      public = 1;
      expect(public, 1);
      public = 2;
      expect(public, 2);
    });
  });

  group('GetterSetter annotation on class fields', () {
    test('can generate getter', () {
      final instance = GetterSetterClass();
      expect(instance.getterOnly, 0);
    });

    test('can generate setter', () {
      final instance = GetterSetterClass();
      instance.setterOnly = 1;
    });

    test('can generate both on a same variable', () {
      final instance = GetterSetterClass();
      instance.both = 1;
      expect(instance.both, 1);
      instance.both = 2;
      expect(instance.both, 2);
    });

    test('has no problem with public fields', () {
      final instance = GetterSetterClass();
      instance.public = 1;
      expect(instance.public, 1);
      instance.public = 2;
      expect(instance.public, 2);
    });
  });
}
