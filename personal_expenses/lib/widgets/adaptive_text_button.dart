import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextButton extends StatelessWidget {
  const AdaptiveTextButton(this._text, this._handler, {Key? key})
      : super(key: key);

  final String _text;
  final Function _handler;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              _text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () => _handler(),
          )
        : TextButton(
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () => _handler(),
            child: Text(
              _text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}
