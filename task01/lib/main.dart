import 'package:flutter/material.dart';
import 'package:task01/text_control.dart';
import 'package:task01/text_output.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const _textos = ['Uno', 'Dos', 'Tres', 'Cuatro'];
  var _textoIndex = 0;

  void changeText() {
    setState(() {
      _textoIndex++;
      if (_textoIndex >= _textos.length) _textoIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Task 01'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextOutput(_textos[_textoIndex]),
            const Divider(
              height: 20,
            ),
            TextControl(changeText),
          ],
        ),
      ),
    );
  }
}
