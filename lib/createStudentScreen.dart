// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:untitled/api_server.dart';
import 'package:untitled/student.dart';
import 'package:http/http.dart' as http;

class CreateStudentScreen extends StatefulWidget {
  const CreateStudentScreen({Key key}) : super(key: key);

  @override
  _CreateStudentScreenState createState() => _CreateStudentScreenState();
}

class _CreateStudentScreenState extends State<CreateStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController dob = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Student"),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            TextFormField(
                // ignore: missing_return
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please enter first name";
                  }
                },
                controller: firstName,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'First Name',
                    labelText: 'First Name')),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
                // ignore: missing_return
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please enter last name";
                  }
                },
                controller: lastName,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Last Name')),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
                // ignore: missing_return
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please enter email";
                  }
                },
                controller: email,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Email')),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
                // ignore: missing_return
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please enter contact";
                  }
                },
                controller: contact,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Contact')),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
                // ignore: missing_return
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please enter contact";
                  }
                },
                controller: address,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Address')),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              // ignore: missing_return
              validator: (String value) {
                if (value.isEmpty) {
                  return "Please enter date of birth";
                }
              },
              controller: dob,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Date Of Birth'),
              keyboardType: TextInputType.number,
              inputFormatters: [
                DateInputFormatter(),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 50,
              width: 500,
              child: RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    Student student = Student(
                        address: address.text,
                        contact: contact.text,
                        dob: dob.text,
                        email: email.text,
                        firstName: firstName.text,
                        lastName: lastName.text,
                        userId: ApiService.userId);
                    String body = jsonEncode(student.toJson());
                    var response = await createStudent(body);
                    if (response.statusCode == 200) {
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text("OK"),
              ),
            )
          ]),
        ),
      )),
    );
  }
}

Future<http.Response> createStudent(String body) async {
  final response = await http.post(Uri.parse(ApiService.apiAddress + "student"),
      body: body, headers: {"Content-Type": "Application/json"});
  return response;
}
