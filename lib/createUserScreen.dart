// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/userAuthentication.dart';

import 'api_server.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({Key key}) : super(key: key);

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  TextEditingController username = TextEditingController();

  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New User"),
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
                          return "Please enter username";
                        }
                      },
                      controller: username,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Username')),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                      // ignore: missing_return
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter password";
                        }
                      },
                      obscureText: true,
                      controller: password,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Password')),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                      // ignore: missing_return
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter confirm password";
                        }
                        if (value != password.text) {
                          return "Password not match";
                        }
                      },
                      obscureText: true,
                      controller: confirmPassword,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Confirm Password')),
                  const SizedBox(
                    height: 10.0,
                  ),
                  // ignore: deprecated_member_use
                  TextButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        UserAuthentication obj = UserAuthentication(
                            username: username.text, password: password.text);
                        String body = json.encode(obj.toJson());
                        var responseCode = await createUser(body);
                        if (responseCode.statusCode == 200) {
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: const Text("OK"),
                  )
                ],
              ),
            )),
      ),
    );
  }
}

Future<http.Response> createUser(String body) async {
  Uri uri = Uri.parse(ApiService.apiAddress + "user");
  var response = await http
      .post(uri, body: body, headers: {"Content-Type": "Application/json"});
  return response;
}
