// ignore_for_file: prefer_final_fields

import 'package:annotations/annotations.dart';

part 'getter_setter.g.dart';

@getter
int _getterOnly = 0;

@setter
int _setterOnly = 0;

@getter
@setter
int _both = 0;

@applyGS
class GetterSetterClass {
  @getter
  int _getterOnly = 0;

  @setter
  int _setterOnly = 0;

  @getter
  @setter
  int _both = 0;
}
