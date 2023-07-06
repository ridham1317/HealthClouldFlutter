//
// import 'package:flutter/material.dart';
//
// import 'Gradient_container.dart';
//
// void main() {
//   runApp(
//      const MaterialApp(
//       home: Scaffold(
//         body: GradientContainer(),
//       ),
//     ),
//   );
// }
//
//
//

import 'package:flutter/material.dart';
import 'package:speech_to_text_demo/views/ResultPage.dart';

import 'views/homepage.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    late Map<String, dynamic> formValues = {
      "firstName": "Sarah",
      "lastName": "Joe",
      "age":25,
      "gender":"female",
      "bloodGroup": "A+",
      "symptoms": "severe back pain and headache",
      "prescription": "3 doses of stopache every 6hrs and physical exercise 1hr each day",
      "disease": "meningitis",
      "department": "pediatrician",
      "nextSchedule": "2024-01-04",
      "recommendedFood": "lentils and rice",
      "restrictedFood": "junk food such as pizza",
      "bloodPressure": 120.5,
      "diabetesLevel": 200.0
    };
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
    );
  }
}
