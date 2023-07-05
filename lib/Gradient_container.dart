import 'package:flutter/material.dart';
import 'package:speech_to_text_demo/Text_widget.dart';

class GradientContainer extends StatelessWidget{

  const GradientContainer({key}): super(key: key);

  @override
  Widget build(context){
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 26, 2, 80),
            Color.fromARGB(255, 45, 7, 98)
          ],
              begin: Alignment.topLeft,
              end:Alignment.bottomRight)
      ),
      child: const Center(
        child: TextWidget()
      ),
    );
  }
}