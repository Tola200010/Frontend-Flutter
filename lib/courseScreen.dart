// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/course.dart';
import 'package:untitled/editCourseScreen.dart';
import 'api_server.dart';
import 'createCourseScreen.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key key}) : super(key: key);

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  Future future;

  //final formatCurrency =  NumberFormat.simpleCurrency();
  @override
  void initState() {
    future = getCourse();
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
                    builder: (context) => const CreateCourseScreen()));
          },
        ),
        appBar: AppBar(
          title: const Text("Course"),
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
                        leading: const Icon(FontAwesomeIcons.python),
                        title: Text(snapshot.data[index].name),
                        subtitle: Text(snapshot.data[index].price.toString()),
                        trailing: Wrap(
                          children: <Widget>[
                            IconButton(
                                onPressed: () {
                                  var course = snapshot.data[index];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditCourseScreen(
                                                course: course,
                                              )));
                                  setState(() {
                                    future = getCourse();
                                  });
                                },
                                icon: const Icon(Icons.edit)),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                customDialog(
                                    context,
                                    "Delete",
                                    "Do you want to delete " +
                                        snapshot.data[index].name +
                                        " ?", () async {
                                  var id = snapshot.data[index].id;
                                  var response = await deleteCourse(id);
                                  if (response.statusCode == 200) {
                                    setState(() {
                                      future = getCourse();
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
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}

Future<List<Course>> getCourse() async {
  final response = await http.get(Uri.parse(ApiService.apiAddress + "course"));
  List<Course> courses = <Course>[];
  if (response.statusCode == 200) {
    var list = (json.decode(response.body) as List)
        .map((e) => Course.fromJson(e))
        .toList();
    courses = list;
    //  print(courses);
  }
  return courses;
}

Future<http.Response> deleteCourse(int id) async {
  final response = await http
      .delete(Uri.parse(ApiService.apiAddress + "course/" + id.toString()));
  return response;
}

customDialog(BuildContext buildContext, String title, String message,
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
