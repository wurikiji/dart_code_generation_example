// ignore_for_file: prefer_final_fields, unused_element, unused_field

import 'package:annotations/annotations.dart';

part 'getter_setter.g.dart';

@getter
int _getterOnly = 0;

@setter
int _setterOnly = 0;

@getter
@setter
int _both = 0;

@getter
@setter
int public = 0;

class GetterSetterClass {
  @getter
  int _getterOnly = 0;

  @setter
  int _setterOnly = 0;

  @getter
  @setter
  int _both = 0;

  @getter
  @setter
  int public = 0;
}
