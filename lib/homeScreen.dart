// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/courseScreen.dart';
import 'package:untitled/menuButton.dart';
import 'package:untitled/studentScreen.dart';
import 'package:untitled/teacherScreen.dart';
import 'package:untitled/userScreen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  BuildContext buildContext;

  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    return Scaffold(
      appBar: customAppBar,
      body: customBody,
      drawer: const Drawer(),
    );
  }

  AppBar get customAppBar {
    return AppBar(
      backgroundColor: Colors.green,
      title: const Text("ENROLLMENT"),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notification_add,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.call,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Widget get customBody {
    return Column(
      children: [
        Flexible(
            flex: 2,
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              padding: const EdgeInsets.all(2.0),
              children: [
                MenuBUtton(
                  icon: Icons.account_circle,
                  size: 48,
                  title: "Users",
                  onpress: () {
                    Navigator.push(
                        buildContext,
                        MaterialPageRoute(
                            builder: (context) => const UserScreen()));
                  },
                ),
                MenuBUtton(
                  icon: FontAwesomeIcons.chalkboardTeacher,
                  size: 40,
                  title: "Teacher",
                  onpress: () {
                    Navigator.push(
                        buildContext,
                        MaterialPageRoute(
                            builder: (context) => const TeacherScreen()));
                  },
                ),
                MenuBUtton(
                  icon: FontAwesomeIcons.userGraduate,
                  size: 40,
                  title: "Student",
                  onpress: () {
                    Navigator.push(
                        buildContext,
                        MaterialPageRoute(
                            builder: (context) => const StudentScreen()));
                  },
                ),
                MenuBUtton(
                  icon: Icons.cast_for_education,
                  size: 40,
                  title: "Course",
                  onpress: () {
                    Navigator.push(
                        buildContext,
                        MaterialPageRoute(
                            builder: (context) => const CourseScreen()));
                  },
                ),
                MenuBUtton(
                  icon: Icons.app_registration,
                  size: 48,
                  title: "Enrollment",
                  onpress: () {
                    print("heelo");
                  },
                ),
                MenuBUtton(
                  icon: FontAwesomeIcons.chartPie,
                  size: 40,
                  title: "Report",
                  onpress: () {
                    print("heelo");
                  },
                )
              ],
            )),
        Flexible(flex: 1, child: Container(color: Colors.greenAccent)),
        Flexible(flex: 1, child: Container(color: Colors.lightGreen))
      ],
    );
  }
}
