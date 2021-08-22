// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:untitled/course.dart';
import 'package:untitled/teacher.dart';
import 'package:http/http.dart' as http;

import 'api_server.dart';

class CreateCourseScreen extends StatefulWidget {
  const CreateCourseScreen({Key key}) : super(key: key);

  @override
  _CreateCourseScreenState createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController limitStudent = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Teacher> teachers;
  List<DropdownMenuItem<Teacher>> dropdownTeacher;
  Teacher _teacherSelected;

  void loadTeacher() async {
    teachers = await getTeachers();
    setState(() {
      dropdownTeacher = buildDropdownMenuItem(teachers);
      _teacherSelected = dropdownTeacher[1].value;
    });
  }

  List<DropdownMenuItem<Teacher>> buildDropdownMenuItem(List teachers) {
    List<DropdownMenuItem<Teacher>> items = [];
    for (Teacher teacher in teachers) {
      items.add(
          DropdownMenuItem(value: teacher, child: Text(teacher.firstName)));
    }
    return items;
  }

  onChangeTeacherDropDownItem(Teacher teacher) {
    setState(() {
      _teacherSelected = teacher;
    });
  }

  @override
  void initState() {
    super.initState();
    loadTeacher();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Course"),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                      // ignore: missing_return
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter Name";
                        }
                      },
                      controller: name,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Name')),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                      // ignore: missing_return
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter Price";
                        }
                      },
                      controller: price,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        CurrencyTextInputFormatter(
                          decimalDigits: 0,
                          symbol: "\$ ",
                        )
                      ],
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Price')),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                      // ignore: missing_return
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter limit Student";
                        }
                      },
                      controller: limitStudent,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Limit Student')),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ListTile(
                    title: Text(
                        "Start Date : ${startDate.year}-${startDate.month}-${startDate.day}"),
                    trailing: const Icon(Icons.keyboard_arrow_down),
                    onTap: _pickStartDate,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ListTile(
                    title: Text(
                        "End Date : ${endDate.year}-${endDate.month}-${endDate.day}"),
                    trailing: const Icon(Icons.keyboard_arrow_down),
                    onTap: _pickEndDate,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        const Text(
                          "Select Teacher",
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          width: 50.0,
                        ),
                        DropdownButton(
                          value: _teacherSelected,
                          items: dropdownTeacher,
                          onChanged: onChangeTeacherDropDownItem,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  /////. ignore: deprecated_member_use
                  SizedBox(
                    height: 50,
                    width: 500,
                    child: RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          Course course = Course(
                              name: name.text,
                              price:
                                  double.parse(price.text.replaceAll("\$", "")),
                              endDate: endDate.toString(),
                              startDate: startDate.toString(),
                              teacherId: _teacherSelected.id,
                              limitStudent: int.parse(limitStudent.text),
                              userId: ApiService.userId);
                          String body = json.encode(course.toJson());
                          var response = await createCourse(body);
                          if (response.statusCode == 200) {
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: const Text("OK"),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  _pickStartDate() async {
    DateTime datetime = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));
    if (datetime != null) {
      setState(() {
        startDate = datetime;
      });
    }
  }

  _pickEndDate() async {
    DateTime datetime = await showDatePicker(
        context: context,
        initialDate: endDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));
    if (datetime != null) {
      setState(() {
        endDate = datetime;
      });
    }
  }
}

Future<List<Teacher>> getTeachers() async {
  final response = await http.get(Uri.parse(ApiService.apiAddress + "teacher"),
      headers: {"Authorization": "Bearer " + ApiService.token});
  List<Teacher> users = <Teacher>[];
  if (response.statusCode == 200) {
    var list = (json.decode(response.body) as List)
        .map((e) => Teacher.fromJson(e))
        .toList();
    users = list;
  }
  return users;
}

Future<http.Response> createCourse(String body) async {
  Uri uri = Uri.parse(ApiService.apiAddress + "/course");
  var response = await http
      .post(uri, body: body, headers: {"Content-Type": "Application/json"});
  return response;
}
