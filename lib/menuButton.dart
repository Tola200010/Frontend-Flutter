// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MenuBUtton extends StatelessWidget {
  const MenuBUtton({Key key, this.icon, this.title, this.size, this.onpress})
      : super(key: key);
  final IconData icon;
  final String title;
  final double size;
  final Function onpress;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(icon, color: Colors.white, size: size),
          const SizedBox(
            height: 15.0,
          ),
          Text(title,
              style: const TextStyle(
                color: Colors.white,
              ))
        ],
      ),
      onPressed: onpress,
    );
  }
}
