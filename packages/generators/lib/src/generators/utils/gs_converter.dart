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
          element.name!.isPrivate(),
          'Getter/Setter annotation can only be used on private variables',
        );

  final Element element;

  String get name => element.name!;
  DartType get type => (element as dynamic).type;
}

extension ConvertElementsToGetterSetter on Iterable<Element> {
  String toGetters() =>
      where(_annotatedWith<Getter>).map(ConvertToGetter.new).join('\n');
  String toSetters() =>
      where(_annotatedWith<Setter>).map(ConvertToSetter.new).join('\n');
}

extension ConvertElementToGetterSetter on Element {
  String toGetter() => ConvertToGetter(this).toString();
  String toSetter() => ConvertToSetter(this).toString();
}

bool _annotatedWith<T>(Element element) =>
    TypeChecker.fromRuntime(T).hasAnnotationOfExact(element);

extension PublicPrivate on String {
  String toPublic() => replaceFirst(RegExp(r'^_+'), '');
  bool isPrivate() => startsWith('_');
}
