import 'package:annotations/annotations.dart';
import 'package:flutter/material.dart';

part 'main.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutoDispose Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'AutoDispose Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @autoDispose
  // ignore: unused_field
  final TextEditingController? _teController = null;

  @override
  Widget build(BuildContext context) {
    final controller = teController(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: TextField(
          controller: controller,
        ),
      ),
    );
  }
}
