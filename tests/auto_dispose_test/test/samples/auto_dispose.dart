import 'package:annotations/annotations.dart';
import 'package:flutter/material.dart';

part 'auto_dispose.g.dart';

class AutoDisposeController extends StatelessWidget {
  const AutoDisposeController({Key? key}) : super(key: key);
  @autoDispose
  final TextEditingController? _controller = null;

  @override
  Widget build(BuildContext context) {
    return TextField(controller: controller(context));
  }
}

class MultipleAutoDisposeTestWidget extends StatelessWidget {
  const MultipleAutoDisposeTestWidget({super.key});

  @autoDispose
  final TextEditingController? _controller1 = null;
  @autoDispose
  final TextEditingController? _controller2 = null;
  @autoDispose
  final TextEditingController? _controller3 = null;
  @autoDispose
  final TextEditingController? _controller4 = null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(controller: controller1(context)),
        TextField(controller: controller2(context)),
        TextField(controller: controller3(context)),
        TextField(controller: controller4(context)),
      ],
    );
  }
}
