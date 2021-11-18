import 'dart:async' show Future;
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:json/model/student_model.dart';

Future<String> _loadAStudentAsset() async {
  return await rootBundle.loadString('assets/student.json');
}

Future loadStudent() async {
  String jsonString = await _loadAStudentAsset();
  final jsonResponse = json.decode(jsonString);
  Student student = new Student.fromJson(jsonResponse);
  // print(student.studentScores);
  return student;
  //return student.studentName;
  //print(student.studentName);
}
