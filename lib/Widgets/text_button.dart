import 'package:flutter/material.dart';

Widget textButton(title, context, t1, d1) {
  return TextButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(
                      color: Theme.of(context).colorScheme.primary)))),
      child: Text(title),
      onPressed: () {
        t1.text = '';
        d1.text = '';
      });
}
