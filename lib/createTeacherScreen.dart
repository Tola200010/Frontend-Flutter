// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/teacher.dart';

import 'api_server.dart';

class CreateTeacherScreen extends StatefulWidget {
  const CreateTeacherScreen({Key key}) : super(key: key);
  @override
  State<CreateTeacherScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateTeacherScreen> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController address = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Teacher"),
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
                          return "Please enter first name";
                        }
                      },
                      controller: firstName,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'First Name')),
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
                          border: OutlineInputBorder(), hintText: 'Last Name')),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                      controller: contact,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Contact')),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Email')),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                      controller: address,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Address')),
                  const SizedBox(
                    height: 10.0,
                  ),
                  // ignore: deprecated_member_use
                  SizedBox(
                    height: 50,
                    width: 500,
                    child: TextButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          var teacher = Teacher(
                              firstName: firstName.text,
                              lastName: lastName.text,
                              address: address.text,
                              contact: contact.text,
                              email: email.text);
                          var body = jsonEncode(teacher.toJson());
                          var response = await createTeacher(body);
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
}

Future<http.Response> createTeacher(String body) async {
  Uri uri = Uri.parse(ApiService.apiAddress + "teacher");
  var response = await http
      .post(uri, body: body, headers: {"Content-Type": "Application/json"});
  return response;
}
