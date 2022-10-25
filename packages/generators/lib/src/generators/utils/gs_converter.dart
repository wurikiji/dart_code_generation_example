import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:annotations/annotations.dart';
import 'package:source_gen/source_gen.dart';

class ConvertToGetter extends ConvertVariable {
  ConvertToGetter(super.element);

  @override
  String toString() => '$type get ${name.toPublic()} => $name;';
}

class ConvertToSetter extends ConvertVariable {
  ConvertToSetter(super.element);

  @override
  String toString() =>
      'set ${name.toPublic()}($type newVal) => $name = newVal;';
}

abstract class ConvertVariable {
  ConvertVariable(this.element)
      : assert(
          element is VariableElement || element is FieldElement,
          'Getter/Setter annotation can only be used on variables and class fields',
        ),
        assert(
          element.isPrivate,
          'Getter/Setter annotation can only be used on private variables',
        );

  final Element element;

  String get name => element.name!;
  DartType get type => (element as dynamic).type;
}

extension ConvertElementsToGetterSetter on Iterable<Element> {
  String toGetters() => where((e) => e.isPrivate)
      .where(annotateWithGetter)
      .map(ConvertToGetter.new)
      .join('\n');
  String toSetters() => where((e) => e.isPrivate)
      .where(annotateWithSetter)
      .map(ConvertToSetter.new)
      .join('\n');
}

bool annotateWithGetter(Element element) => _annotatedWith<Getter>(element);
bool annotateWithSetter(Element element) => _annotatedWith<Setter>(element);

bool _annotatedWith<T>(Element element) =>
    TypeChecker.fromRuntime(T).hasAnnotationOf(element);

extension PublicPrivate on String {
  String toPublic() => replaceFirst(RegExp(r'^_+'), '');
}
