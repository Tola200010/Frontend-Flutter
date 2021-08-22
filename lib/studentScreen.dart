// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:untitled/EditStudentScreen.dart';
import 'package:untitled/createStudentScreen.dart';
import 'package:untitled/student.dart';
import 'package:http/http.dart' as http;
import 'api_server.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({Key key}) : super(key: key);

  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  Future future;

  @override
  void initState() {
    super.initState();
    future = getStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateStudentScreen()));
        },
      ),
      appBar: AppBar(
        title: const Text("Students"),
      ),
      body: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {},
                      leading: const Icon(Icons.person),
                      title: Text(snapshot.data[index].firstName +
                          " " +
                          snapshot.data[index].lastName),
                      subtitle: Text(snapshot.data[index].email),
                      trailing: Wrap(
                        children: <Widget>[
                          IconButton(
                              onPressed: () {
                                var student = snapshot.data[index];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditStudentScreen(
                                              student: student,
                                            )));
                                setState(() {
                                  future = getStudents();
                                });
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              customShowDialog(
                                  context,
                                  "Delete",
                                  "Do you want to delete " +
                                      snapshot.data[index].firstName +
                                      " ?", () async {
                                var id = snapshot.data[index].id;
                                var response = await deleteStudent(id);
                                if (response.statusCode == 200) {
                                  setState(() {
                                    future = getStudents();
                                  });
                                }
                                Navigator.pop(context);
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  });
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}

Future<List<Student>> getStudents() async {
  final response = await http.get(Uri.parse(ApiService.apiAddress + "student"),
      headers: {"Authorization": "Bearer " + ApiService.token});
  List<Student> students = <Student>[];
  if (response.statusCode == 200) {
    var list = (json.decode(response.body) as List)
        .map((e) => Student.fromJson(e))
        .toList();
    students = list;
  }
  return students;
}

Future<http.Response> deleteStudent(int id) async {
  final response = await http.delete(
      Uri.parse(ApiService.apiAddress + "student/" + id.toString()),
      headers: {"Authorization": "Bearer " + ApiService.token});
  return response;
}

customShowDialog(BuildContext buildContext, String title, String message,
    Function onOkPress) {
  showDialog(
      context: buildContext,
      builder: (buildContext) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              FlatButton(onPressed: onOkPress, child: const Text("Yes")),
              FlatButton(
                  onPressed: () {
                    Navigator.of(buildContext).pop("Cancel");
                  },
                  child: const Text("No"))
            ],
          ));
}
