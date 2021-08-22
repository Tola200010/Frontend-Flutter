// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:untitled/api_server.dart';
import 'package:untitled/createUserScreen.dart';
import 'package:untitled/user.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class UserScreen extends StatefulWidget {
  const UserScreen({Key key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Future future;
  @override
  void initState() {
    future = getUser();
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
                    builder: (context) => const CreateUserScreen()));
            setState(() {
              future = getUser();
            });
          },
        ),
        appBar: AppBar(title: const Text("User")),
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
                        title: Text(snapshot.data[index].username),
                        subtitle: Text(snapshot.data[index].createdAt),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            showDailog(
                                context, "Delete", "Do you want to delete",
                                () async {
                              var id = snapshot.data[index].id;
                              print(id);
                              var response = await deleteUser(id);
                              print(response.statusCode);
                              if (response.statusCode == 202) {
                                setState(() {
                                  future = getUser();
                                });
                              }
                              Navigator.pop(context);
                            });
                          },
                        ),
                      );
                    });
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }
}

Future<List<User>> getUser() async {
  final response = await http.get(Uri.parse(ApiService.apiAddress + "user"),
      headers: {"Authorization": "Bearer " + ApiService.token});
  List<User> users = <User>[];
  if (response.statusCode == 200) {
    var list = (json.decode(response.body) as List)
        .map((e) => User.fromJson(e))
        .toList();
    users = list;
  }
  return users;
}

Future<http.Response> deleteUser(int id) async {
  final response = await http
      .delete(Uri.parse(ApiService.apiAddress + "user/" + id.toString()));
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
              FlatButton(onPressed: onOkPress, child: const Text("Yes")),
              FlatButton(
                  onPressed: () {
                    Navigator.of(buildContext).pop("Cancel");
                  },
                  child: const Text("No"))
            ],
          ));
}
