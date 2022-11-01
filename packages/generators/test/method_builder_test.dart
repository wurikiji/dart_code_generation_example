import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:generators/builders.dart';
import 'package:test/test.dart';

Future main() async {
  group('GetterSetterBuilder with asMethod on the global context', () {
    test('can generate getter only as a method', () async {
      await testBuilder(
        getterSetterBuilder(BuilderOptions.empty),
        {
          'generators|test/getter.dart': r'''
import 'package:annotations/annotations.dart';

@Getter(asMethod: true)
int _getterOnly = 0;
''',
        },
        outputs: {
          'generators|test/getter.getter_setter_builder.g.part': decodedMatches(
            allOf(
              [
                contains('int getGetterOnly() => _getterOnly;'),
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

@Setter(asMethod: true)
int _setterOnly= 0;
''',
        },
        outputs: {
          'generators|test/setter.getter_setter_builder.g.part': decodedMatches(
            allOf(
              [
                contains('setSetterOnly(int newVal) => _setterOnly = newVal;'),
              ],
            ),
          ),
        },
        reader: await PackageAssetReader.currentIsolate(),
      );
    });
  });
}
