import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({super.key});

  @override
  Widget build(context) {
    return const Text(
      'This is custom widget',
      style: TextStyle(color: Colors.white, fontSize: 28.0),
    );
  }
}
