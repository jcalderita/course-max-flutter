import 'package:flutter/material.dart';

class TextControl extends StatelessWidget {
  final VoidCallback changeTexto;
  const TextControl(this.changeTexto, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: changeTexto, child: const Text('Change Text!'));
  }
}
