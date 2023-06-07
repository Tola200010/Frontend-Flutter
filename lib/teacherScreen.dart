// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/createTeacherScreen.dart';
import 'package:untitled/teacher.dart';

import 'api_server.dart';
import 'editTeacherScreen.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({Key key}) : super(key: key);

  @override
  _TeacherScreenState createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  Future future;

  @override
  void initState() {
    future = getTeachers();
    super.initState();
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
                    builder: (context) => const CreateTeacherScreen()));
          },
        ),
        appBar: AppBar(title: const Text("Teachers")),
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
                        subtitle: Text(snapshot.data[index].createdAt),
                        trailing: Wrap(
                          children: <Widget>[
                            IconButton(
                                onPressed: () {
                                  var teacher = snapshot.data[index];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditTeacherScreen(
                                                teacher: teacher,
                                              )));
                                  setState(() {
                                    future = getTeachers();
                                  });
                                },
                                icon: const Icon(Icons.edit)),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                showDailog(
                                    context,
                                    "Delete",
                                    "Do you want to delete " +
                                        snapshot.data[index].firstName +
                                        " ?", () async {
                                  var id = snapshot.data[index].id;
                                  var response = await deleteUser(id);
                                  if (response.statusCode == 202) {
                                    setState(() {
                                      future = getTeachers();
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
            }));
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

Future<http.Response> deleteUser(int id) async {
  final response = await http
      .delete(Uri.parse(ApiService.apiAddress + "teacher/" + id.toString()));
  return response;
}

showDailog(BuildContext buildContext, String title, String message,
    Function onOkPress) {
  showDialog(
      context: buildContext,
      builder: (buildContext) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(onPressed: onOkPress, child: const Text("Yes")),
              TextButton(
                  onPressed: () {
                    Navigator.of(buildContext).pop("Cancel");
                  },
                  child: const Text("No"))
            ],
          ));
}
