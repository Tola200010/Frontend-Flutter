// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/api_server.dart';
import 'package:untitled/userAuthentication.dart';

// ignore: camel_case_types
class set_up_page extends StatefulWidget {
  const set_up_page({Key key}) : super(key: key);

  @override
  _set_up_pageState createState() => _set_up_pageState();
}

// ignore: camel_case_types
class _set_up_pageState extends State<set_up_page> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 150,
                  width: 150,
                  child: CircleAvatar(
                      backgroundColor: Colors.brown.shade800,
                      child: const Icon(
                        Icons.person,
                        size: 100,
                      )),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                TextField(
                    controller: username,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Username')),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                    controller: password,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Password')),
                const SizedBox(
                  height: 10.0,
                ),
                const TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Confirm Password')),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: 500,
                  height: 50,
                  child: ElevatedButton(
                      child: const Text('SetUp'),
                      onPressed: () async {
                        UserAuthentication obj = UserAuthentication(
                            username: username.text, password: password.text);
                        String body = json.encode(obj.toJson());
                        var responseCode = await createUser(body);
                        // ignore: avoid_print
                        print(responseCode.statusCode);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<http.Response> createUser(String body) async {
  print(body);
  Uri uri = Uri.parse(ApiService.apiAddress + "user");
  var response = await http
      .post(uri, body: body, headers: {"Content-Type": "Application/json"});
  return response;
}
