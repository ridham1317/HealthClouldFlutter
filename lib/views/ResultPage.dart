import 'dart:convert';

import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  final Map<String, dynamic> jsonData;

  const ResultPage({Key? key, required this.jsonData}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class FormValues {
  String? firstName;
  String? lastName;
  int? age;
  String? gender;
  String? bloodGroup;
  String? symptoms;
  String? prescription;
  String? disease;
  String? department;
  DateTime? nextSchedule;
  String? recommendedFood;
  String? restrictedFood;
  double? bloodPressure;
  double? diabetesLevel;
}

class _ResultPageState extends State<ResultPage> {
  late Map<String, dynamic> formValues;

  @override
  void initState() {
    super.initState();
    // Initialize form values with the initial field values from jsonData
    formValues = Map.fromEntries(widget.jsonData.entries.map((entry) =>
        MapEntry(entry.key, entry.value.toString())));
  }

  @override
  Widget build(BuildContext context) {

    FormValues _formValues = FormValues();

    setState(() {
      _formValues.firstName = formValues['firstName'];
      _formValues.lastName = formValues['lastName'];
      _formValues.gender = formValues['gender'];
      _formValues.bloodGroup = formValues['bloodGroup'];
      _formValues.symptoms = formValues['symptoms'];
      _formValues.prescription = formValues['prescription'];
      _formValues.disease = formValues['disease'];
      _formValues.department = formValues['department'];
      _formValues.restrictedFood=formValues['restrictedFood'];
      _formValues.recommendedFood = formValues['recommendedFood'];
    });

    print(formValues['firstName']);
    print(formValues['lastName']);

    String? nextScheduleStr = formValues['nextSchedule'];
    print(nextScheduleStr);
    if (nextScheduleStr != null && nextScheduleStr!='' && nextScheduleStr!='null') {
      _formValues.nextSchedule = DateTime.parse(nextScheduleStr);
    }
    else{
      _formValues.nextSchedule = DateTime.now();
    }

    String? ageStr = formValues['age'];
    if (ageStr != null) {
      _formValues.age = int.tryParse(ageStr);
    } else {
      _formValues.age = null; // or assign a default value if needed
    }

    String? bloodPressureStr = formValues['bloodPressure'];
    if (bloodPressureStr != null) {
      _formValues.bloodPressure = double.tryParse(bloodPressureStr);
    } else {
      _formValues.bloodPressure = null; // or assign a default value if needed
    }

    String? diabetesLevelStr = formValues['diabetesLevel'];
    if (diabetesLevelStr != null) {
      _formValues.diabetesLevel = double.tryParse(diabetesLevelStr);
    } else {
      _formValues.diabetesLevel = null; // or assign a default value if needed
    }

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Result'),
    //   ),
    //   body: SingleChildScrollView(
    //     padding: const EdgeInsets.all(16),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: formValues.entries.map((entry) {
    //         final fieldName = entry.key;
    //         final fieldController = TextEditingController(text: entry.value);
    //
    //         return Padding(
    //           padding: const EdgeInsets.only(bottom: 8),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 fieldName,
    //                 style: const TextStyle(
    //                   fontSize: 18,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //               SizedBox(height: 4),
    //               TextFormField(
    //                 controller: fieldController,
    //                 style: const TextStyle(fontSize: 16),
    //                 onChanged: (newValue) {
    //                   // Update the form value for the specific field
    //                   formValues[fieldName] = newValue;
    //                 },
    //               ),
    //             ],
    //           ),
    //         );
    //       }).toList(),
    //     ),
    //   ),
    // );

    return Scaffold(
          appBar: AppBar(
            title: const Text('Result'),
          ),
        body : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child:
        Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'First Name'),
            initialValue: _formValues.firstName,
            onChanged: (value) {
              setState(() {
                _formValues.firstName = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Last Name'),
            initialValue: _formValues.lastName,
            onChanged: (value) {
              setState(() {
                _formValues.lastName = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Age'),
            keyboardType: TextInputType.number,
            initialValue: _formValues.age.toString(),
            onChanged: (value) {
              setState(() {
                _formValues.age = int.tryParse(value);
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Gender'),
            initialValue: _formValues.gender,
            onChanged: (value) {
              setState(() {
                _formValues.gender = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Blood Group'),
            initialValue: _formValues.bloodGroup,
            onChanged: (value) {
              setState(() {
                _formValues.bloodGroup = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Symptoms'),
            initialValue: _formValues.symptoms,
            onChanged: (value) {
              setState(() {
                _formValues.symptoms = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Prescription'),
            initialValue: _formValues.prescription,
            onChanged: (value) {
              setState(() {
                _formValues.prescription = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Disease'),
            initialValue: _formValues.disease,
            onChanged: (value) {
              setState(() {
                _formValues.disease = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Department'),
            initialValue: _formValues.department,
            onChanged: (value) {
              setState(() {
                _formValues.department = value;
              });
            },
          ),
          GestureDetector(
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              ).then((selectedDate) {
                if (selectedDate != null) {
                  setState(() {
                    _formValues.nextSchedule = selectedDate;
                    print(_formValues.nextSchedule);
                  });
                }
              });
            },
            child: AbsorbPointer(
              child: TextFormField(
                controller: TextEditingController(
                  text: _formValues.nextSchedule?.toString() ?? '',
                ),
                decoration: InputDecoration(
                  labelText: 'Next Schedule',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Restricted Food'),
            initialValue: _formValues.restrictedFood,
            onChanged: (value) {
              setState(() {
                _formValues.restrictedFood = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Blood Pressure'),
            initialValue: _formValues.bloodPressure.toString(),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              setState(() {
                _formValues.bloodPressure = double.tryParse(value);
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Diabetes Level'),
            initialValue: _formValues.diabetesLevel.toString(),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              setState(() {
                _formValues.diabetesLevel = double.tryParse(value);
              });
            },
          ),
          // Repeat the pattern for other fields
          // ...
        ],
    ),

        )
    );
  }
}
