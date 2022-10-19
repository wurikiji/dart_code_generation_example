import 'package:annotations/annotations.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldGenerate(
  r'''
extension on MyClass {
  int get hello => _hello;
}
''',
  contains: true,
)
@GetterSetter(
  getter: true,
  setter: false,
)
class GenerateGetterOnly {
  // ignore: prefer_final_fields
  int _hello = 0;
}
