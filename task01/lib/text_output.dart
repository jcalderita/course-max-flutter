import 'package:flutter/material.dart';

class TextOutput extends StatelessWidget {
  final String texto;
  const TextOutput(this.texto, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: Text(texto),
      );
}
