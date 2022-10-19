import 'package:generators/src/generators/getter_setter_gnerator.dart';
import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';

Future<void> main() async {
  initializeBuildLogTracking();
  final reader = await initializeLibraryReaderForDirectory(
    'test/generators/samples',
    'getter_only.dart',
  );

  testAnnotatedElements(reader, GetterSetterGenerator());

  test('should generate extension with getter', () async {
    // final libs = await (await resolveSources(
    //   {
    //     'generators|test/generators/samples/getter_only.dart': useAssetReader,
    //   },
    //   (r) => r.libraries.where(
    //     (element) => element.source.toString().contains('extension'),
    //   ),
    // ))
    //     .toList();

    // expect(libs, hasLength(1));

    // final generated = libs[0];

    // final ext = generated.accessibleExtensions.firstWhere(
    //   (element) =>
    //       element.extendedType.getDisplayString(withNullability: false) ==
    //       'MyClass',
    // );
    // expect(ext.getGetter('hello'), isNotNull);
  });
}
