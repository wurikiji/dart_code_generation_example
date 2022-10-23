import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:generators/builders.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

Future main() async {
  group('GetterSetterBuilder on the global context', () {
    test('can generate getter only', () async {
      await testBuilder(
        getterSetterBuilder(BuilderOptions.empty),
        {
          'generators|test/getter.dart': r'''
import 'package:annotations/annotations.dart';

@getter
int _getterOnly = 0;
''',
        },
        outputs: {
          'generators|test/getter.getter_setter_builder.g.part': decodedMatches(
            allOf(
              [
                contains('int get getterOnly => _getterOnly;'),
                isNot(contains('set getterOnly')),
              ],
            ),
          ),
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
    });
    test('can generate setter only', () async {
      await testBuilder(
        getterSetterBuilder(BuilderOptions.empty),
        {
          'generators|test/setter.dart': r'''
import 'package:annotations/annotations.dart';

@setter
int _setterOnly= 0;
''',
        },
        outputs: {
          'generators|test/setter.getter_setter_builder.g.part': decodedMatches(
            allOf(
              [
                contains('set setterOnly(int newVal) => _setterOnly = newVal;'),
                isNot(contains('int get setterOnly => _setterOnly;')),
              ],
            ),
          ),
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
    });
    test('can generate getter only', () async {
      await testBuilder(
        getterSetterBuilder(BuilderOptions.empty),
        {
          'generators|test/getter_setter.dart': r'''
import 'package:annotations/annotations.dart';

@getter
@setter
int _both = 0;
''',
        },
        outputs: {
          'generators|test/getter_setter.getter_setter_builder.g.part':
              decodedMatches(
            allOf(
              [
                contains('int get both => _both;'),
                contains('set both(int newVal) => _both = newVal;'),
              ],
            ),
          ),
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
    });

    test('should throw on public variables', () async {
      final mockWriter = MockWriter();
      registerFallbackValue(AssetId('', ''));
      registerFallbackValue('');
      registerFallbackValue(<int>[]);
      when(() => mockWriter.writeAsString(any(), any()))
          .thenThrow('should not be called');
      when(() => mockWriter.writeAsBytes(any(), any()))
          .thenThrow('should not be called');
      await testBuilder(
        getterSetterBuilder(BuilderOptions.empty),
        {
          'generators|test/getter_setter.dart': r'''
import 'package:annotations/annotations.dart';

@getter
@setter
int both = 0;
''',
        },
        writer: mockWriter,
        reader: await PackageAssetReader.currentIsolate(),
      );
      verifyNever(() => mockWriter.writeAsString(any(), any()));
      verifyNever(() => mockWriter.writeAsBytes(any(), any()));
    });
  });
  group('GetterSetterBuilder on the class fields', () {
    test('can generate getter only', () async {
      await testBuilder(
        getterSetterBuilder(BuilderOptions.empty),
        {
          'generators|test/getter.dart': r'''
import 'package:annotations/annotations.dart';

class Testing {
  @getter
  int _getterOnly = 0;
}
''',
        },
        outputs: {
          'generators|test/getter.getter_setter_builder.g.part': decodedMatches(
            allOf(
              [
                getterMatcher,
                isNot(contains('set getterOnly')),
              ],
            ),
          ),
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
    });
    test('can generate setter only', () async {
      await testBuilder(
        getterSetterBuilder(BuilderOptions.empty),
        {
          'generators|test/setter.dart': r'''
import 'package:annotations/annotations.dart';

class Testing {
@setter
int _setterOnly= 0;
}
''',
        },
        outputs: {
          'generators|test/setter.getter_setter_builder.g.part': decodedMatches(
            allOf(
              [
                setterMatcher,
                isNot(contains('int get setterOnly => _setterOnly;')),
              ],
            ),
          ),
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
    });
    test('can generate getter only', () async {
      await testBuilder(
        getterSetterBuilder(BuilderOptions.empty),
        {
          'generators|test/getter_setter.dart': r'''
import 'package:annotations/annotations.dart';

class Testing {
  @getter
  @setter
  int _both = 0;
}
''',
        },
        outputs: {
          'generators|test/getter_setter.getter_setter_builder.g.part':
              decodedMatches(
            anyOf(
              [
                bothMatcher,
                bothMatcher2,
              ],
            ),
          ),
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
    });

    test('should throw on public variables', () async {
      final mockWriter = MockWriter();
      registerFallbackValue(AssetId('', ''));
      registerFallbackValue('');
      registerFallbackValue(<int>[]);
      when(() => mockWriter.writeAsString(any(), any()))
          .thenThrow('should not be called');
      when(() => mockWriter.writeAsBytes(any(), any()))
          .thenThrow('should not be called');
      await testBuilder(
        getterSetterBuilder(BuilderOptions.empty),
        {
          'generators|test/getter_setter.dart': r'''
import 'package:annotations/annotations.dart';

@getter
@setter
int both = 0;
''',
        },
        writer: mockWriter,
        reader: await PackageAssetReader.currentIsolate(),
      );
      verifyNever(() => mockWriter.writeAsString(any(), any()));
      verifyNever(() => mockWriter.writeAsBytes(any(), any()));
    });
  });
}

class MockWriter extends Mock implements InMemoryAssetWriter {}

final bothMatcher = matches(r'''
extension\s+TestingGetterSetter\s+on\s+Testing\s*{\s*int\s+get\s+both\s*=>\s*_both;\s*set\s+both\s*\(int\s+newVal\)\s*=>\s*_both\s*=\s*newVal;\s*}
''');
// Same RegExp but setter first.
final bothMatcher2 = matches(r'''
extension\s+TestingGetterSetter\s+on\s+Testing\s*{\s*set\s+both\s*\(int\s+newVal\)\s*=>\s*_both\s*=\s*newVal;\s*int\s+get\s+both\s*=>\s*_both;\s*}
''');
// Same RegExp but without setter.
final getterMatcher = matches(r'''
extension\s+TestingGetterSetter\s+on\s+Testing\s*{\s*int\s+get\s+getterOnly\s*=>\s*_getterOnly;\s*}
''');
// Same RegExp but without getter.
final setterMatcher = matches(r'''
extension\s+TestingGetterSetter\s+on\s+Testing\s*{\s*set\s+setterOnly\s*\(int\s+newVal\)\s*=>\s*_setterOnly\s*=\s*newVal;\s*}
''');
