import 'package:analyzer/dart/element/element.dart';
import 'package:annotations/annotations.dart';
import 'package:source_gen/source_gen.dart';

extension ConvertElementsToGetterSetter on Iterable<Element> {
  String toGetters() => where(annotatedWith<Getter>).map(getterFor).join('\n');
  String toSetters() => where(annotatedWith<Setter>).map(setterFor).join('\n');
}

extension ConvertElementToGetterSetter on Element {
  String toGetter() => getterFor(this);

  String toSetter() => setterFor(this);
}

bool annotatedWith<T>(Element element) =>
    TypeChecker.fromRuntime(T).hasAnnotationOfExact(element);

String getterFor(Element element) {
  if (element is! VariableElement && element is! FieldElement) {
    throw 'Getter annotation can only be used on variables and class fields';
  }

  final type = (element as dynamic).type;
  final name = element.name!;
  if (!name.startsWith('_')) {
    throw 'Getter annotation can only be used on private variables';
  }
  final getter = name.substring(1);
  return '''
$type get $getter => $name;
''';
}

String setterFor(Element element) {
  if (element is! VariableElement && element is! FieldElement) {
    throw 'Setter annotation can only be used on variables and class fields';
  }

  final type = (element as dynamic).type;
  final name = element.name!;
  if (!name.startsWith('_')) {
    throw 'Getter annotation can only be used on private variables';
  }
  final setter = name.substring(1);
  return '''
set $setter($type newVal) => $name = newVal;
''';
}
