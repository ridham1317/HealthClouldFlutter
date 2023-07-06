import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

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

  FormValues(
      {this.firstName,
        this.lastName,
        this.age,
        this.gender,
        this.bloodGroup,
        this.symptoms,
        this.prescription,
        this.disease,
        this.department,
        this.nextSchedule,
        this.recommendedFood,
        this.restrictedFood,
        this.bloodPressure,
        this.diabetesLevel});

  // Default constructor
  FormValues.defaultConstructor();

  // FormValues(String firstName, String lastName, int age, String gender, String bloodGroup, String symptoms, String prescription, String disease, String department, DateTime nextSchedule, String recommendedFood, String restrictedFood, double bloodPressure, double diabetesLevel){
  //   this.firstName = firstName;
  //   this.lastName = lastName;
  //   this.age = age;
  //   this.gender = gender;
  //   this.bloodGroup = bloodGroup;
  //   this.symptoms = symptoms;
  //   this.prescription = prescription;
  //   this.disease = disease;
  //   this.department = department;
  //   this.nextSchedule = nextSchedule;
  //   this.recommendedFood = recommendedFood;
  //   this.restrictedFood = restrictedFood;
  //   this.bloodPressure = bloodPressure;
  //   this.diabetesLevel = diabetesLevel;
  // }

  @override
  String toString() {
    return 'FormValues{firstName: $firstName, lastName: $lastName, age: $age, gender: $gender, bloodGroup: $bloodGroup, symptoms: $symptoms, prescription: $prescription, disease: $disease, department: $department, nextSchedule: $nextSchedule, recommendedFood: $recommendedFood, restrictedFood: $restrictedFood, bloodPressure: $bloodPressure, diabetesLevel: $diabetesLevel}';
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'gender': gender,
      'bloodGroup': bloodGroup,
      'symptoms': symptoms,
      'prescription': prescription,
      'disease': disease,
      'department': department,
      'nextSchedule': nextSchedule?.toIso8601String(),
      'recommendedFood': recommendedFood,
      'restrictedFood': restrictedFood,
      'bloodPressure': bloodPressure,
      'diabetesLevel': diabetesLevel,
    };
  }
}

class _ResultPageState extends State<ResultPage> {

  late Map<String, dynamic> formValues;
  TextEditingController _dateController = TextEditingController();
  FormValues _formValues = FormValues();



  @override
  void initState() {
    super.initState();
    // Initialize form values with the initial field values from jsonData
    formValues = Map.fromEntries(widget.jsonData.entries.map((entry) =>
        MapEntry(entry.key, entry.value.toString())));
    _dateController = TextEditingController(text: formValues["nextSchedule"].split('-').reversed.join('-'));

     // _formValues = FormValues();

    setState(() {
      _formValues = FormValues(
        firstName: formValues['firstName'],
        lastName: formValues['lastName'],
        age: formValues['age'] != null ? int.tryParse(formValues['age']) : null,
        gender: formValues['gender'],
        bloodGroup: formValues['bloodGroup'],
        symptoms: formValues['symptoms'],
        prescription: formValues['prescription'],
        disease: formValues['disease'],
        department: formValues['department'],
        nextSchedule: formValues['nextSchedule'] != null && formValues['nextSchedule']!='null'? DateTime.parse(formValues['nextSchedule']) : DateTime.now(),
        recommendedFood: formValues['recommendedFood'],
        restrictedFood: formValues['restrictedFood'],
        bloodPressure: formValues['bloodPressure'] != null ? double.tryParse(formValues['bloodPressure']) : null,
        diabetesLevel: formValues['diabetesLevel'] != null ? double.tryParse(formValues['diabetesLevel']) : null,
      );
    });

    print("AT the end of Initializaion :$_formValues");

  }

  @override
  Widget build(BuildContext context) {

    print("Widget Is Building :$_formValues");
    print(formValues['firstName']);
    print(formValues['lastName']);

    String? nextScheduleStr = formValues['nextSchedule'];
    String? updatedFirstName;
    print(nextScheduleStr);
    if (nextScheduleStr != null && nextScheduleStr != '' && nextScheduleStr != 'null') {
      this._formValues.nextSchedule = DateTime.parse(nextScheduleStr);
    }
    else {
      this._formValues.nextSchedule = DateTime.now();
    }

    this._dateController.text = DateFormat('dd-MM-yyyy').format(this._formValues.nextSchedule!);

    String? ageStr = formValues['age'];
    if (ageStr != null && ageStr!='null' && ageStr!='') {
      this._formValues.age = int.tryParse(ageStr);
    } else {
      this._formValues.age = null; // or assign a default value if needed
    }

    String? bloodPressureStr = formValues['bloodPressure'];
    if (bloodPressureStr != null && bloodPressureStr!='null' && bloodPressureStr!='') {
     this._formValues.bloodPressure = double.tryParse(bloodPressureStr);
    } else {
     this._formValues.bloodPressure = 0.0; // or assign a default value if needed
    }

    String? diabetesLevelStr = formValues['diabetesLevel'];
    if (diabetesLevelStr != null && diabetesLevelStr!='null' && diabetesLevelStr!='') {
      this._formValues.diabetesLevel = double.tryParse(diabetesLevelStr);
    } else {
     this._formValues.diabetesLevel = 0.0; // or assign a default value if needed
    }

    print("Date formed is : ${DateFormat('dd-MM-yyyy').parse(_formValues.nextSchedule.toString())}");

    DateTime initialDate = this._formValues.nextSchedule ?? DateTime.now();
    print(DateFormat('dd-MM-yyyy').format(initialDate));
    print("Blood Pressure is ${this._formValues.bloodPressure}");
    print("Diabetes Level is ${this._formValues.diabetesLevel}");


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
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child:
          Column(
              children: [
          TextFormField(
          decoration: InputDecoration(labelText: 'First Name'),
          initialValue: this._formValues.firstName,

          onChanged: (value) {
            setState(() {
              print(value);
              this._formValues.firstName = value;
              // _formValues.
              print("===============$_formValues");
              updatedFirstName = value;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Last Name'),
          initialValue: _formValues.lastName,
          onChanged: (value) {
            setState(() {
              this._formValues.lastName = value;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Age'),
          keyboardType: TextInputType.number,
          initialValue: _formValues.age != null ? _formValues.age.toString() : '',
          onSaved: (value) {
              this._formValues.age = int.tryParse(value!);
          },
          onChanged: (value) {
            setState(() {
              this._formValues.age = int.tryParse(value);
              formValues["age"] = value;
              print("age-------------------:${this._formValues}");
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Gender'),
          initialValue: _formValues.gender,
          onChanged: (value) {
            setState(() {
              this._formValues.gender = value;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Blood Group'),
          initialValue: _formValues.bloodGroup,
          onChanged: (value) {
            setState(() {
              this._formValues.bloodGroup = value;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Symptoms'),
          initialValue: _formValues.symptoms,
          onChanged: (value) {
            setState(() {
              this._formValues.symptoms = value;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Prescription'),
          initialValue: _formValues.prescription,
          onChanged: (value) {
            setState(() {
              this._formValues.prescription = value;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Disease'),
          initialValue: _formValues.disease,
          onChanged: (value) {
            setState(() {
              this._formValues.disease = value;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Department'),
          initialValue: _formValues.department,

          onChanged: (value) {
            print(value);
            setState(() {
              this._formValues.department = value;
            });
          },
        ),
    GestureDetector(
      onTap: () async {
        DateTime initialDate = this._formValues.nextSchedule ?? DateTime.now();


        final selectedDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime(1600),
          lastDate: DateTime(2100),
        );
        if (selectedDate != null) {
          setState(() {
            this._formValues.nextSchedule = selectedDate;
            this._dateController.text = DateFormat('dd-MM-yyyy').format(selectedDate);
            formValues["nextSchedule"] = DateFormat('yyyy-MM-dd').format(selectedDate);
          });
        }
      },
      child: TextFormField(
        controller: _dateController,
        decoration: InputDecoration(
          labelText: 'Next Schedule',
          suffixIcon: Icon(Icons.calendar_today),
        ),
        enabled: false, // Disable user editing
      ),
    )
    ,

    TextFormField(
    decoration: InputDecoration(labelText: 'Restricted Food'),
    initialValue: _formValues.restrictedFood,
    onChanged: (value) {
    setState(() {
      this._formValues.restrictedFood = value;
    });
    },
    ),
    TextFormField(
    decoration: InputDecoration(labelText: 'Blood Pressure'),
    initialValue: _formValues.bloodPressure.toString(),
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    onChanged: (value) {
    setState(() {
      this._formValues.bloodPressure = double.tryParse(value);
      formValues["bloodPressure"] = value;
    });
    },
    ),
    TextFormField(
    decoration: InputDecoration(labelText: 'Diabetes Level'),
    initialValue: _formValues.diabetesLevel.toString(),
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    onChanged: (value) {
    setState(() {
      this._formValues.diabetesLevel = double.tryParse(value);
      formValues["diabetesLevel"] = value;
    });
    },
    ),
    // Repeat the pattern for other fields
    // ...
                Container(
                  width: 100, // Set the width as per your layout requirements
                  margin: EdgeInsets.all(16.0), // Set the margin as per your layout requirements
                  child: ElevatedButton(
                      onPressed: () async {
                        print("FOrm Values-----------------------------------------${this._formValues}");
                        print("updated firstname : $updatedFirstName");
                        print(_formValues);
                        final response = await http.post(
                          Uri.parse('http://192.1.150.116:8080/medicalForm/patientForm'),
                          body: jsonEncode(this._formValues.toJson()),
                          headers: {'Content-Type': 'application/json'},
                        );

                        if (response.statusCode == 200) {
                          print(response.body);
                        } else {
                          print(response.statusCode);
                        }
                      },
                    child: Text('Save'),
                  ),
                ),
    ],
    ),

    )
    );
  }
}
