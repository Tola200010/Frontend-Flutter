import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/api_server.dart';
import 'package:untitled/homeScreen.dart';
import 'package:untitled/loginResponse.dart';
import 'package:untitled/setUpPage.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/userAuthentication.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Welcome back',
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Login to your account',
                    style: GoogleFonts.inter(
                      fontSize: 23,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 35),
                  TextField(
                      controller: username,
                      decoration: const InputDecoration(
                          labelText: 'E-mail/username',
                          border: OutlineInputBorder(),
                          hintText: 'E-mail/username')),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                      controller: password,
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          hintText: 'password')),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    width: 500,
                    height: 50,
                    child: TextButton(
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blueAccent),
                      ),
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                        // UserAuthentication obj = UserAuthentication(
                        //     username: username.text, password: password.text);
                        // String body = json.encode(obj.toJson());
                        // var responseToken = await login(body);
                        // ApiService.token = responseToken;
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => HomeScreen()));
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    children: const <Widget>[
                      Expanded(child: Divider()),
                      Text("OR"),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: TextButton(
                      child: const Text(
                        'Create new',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const set_up_page()))
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<String> login(String body) async {
  final response = await http.post(Uri.parse(ApiService.apiAddress + "login"),
      body: body, headers: {"Content-Type": "Application/json"});
  if (response.statusCode == 200) {
    var body = LoginResponse.fromJson(jsonDecode(response.body));
    ApiService.userId = body.userId;
    return body.accessToken;
  }
  return null;
}
