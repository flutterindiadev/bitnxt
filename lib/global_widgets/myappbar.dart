import 'package:flutter/material.dart';
import 'package:bitnxt/constants/colors_const.dart';
import 'package:bitnxt/screens/dashboard/bottomnavbar.dart';
import 'package:bitnxt/screens/dashboard/dash.dart';

PreferredSizeWidget myAppBar(
  String title,
  BuildContext context,
) {
  return PreferredSize(
    preferredSize: Size.fromHeight(50),
    child: AppBar(
      leading: InkWell(
          onTap: () {
            if (title == 'Dashboard') {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Already on the Homepage')));
            } else {
              Navigator.of(context).pushReplacementNamed(BottomNav.routename);
            }
          },
          child: Icon(
            Icons.home,
            color: Colors.white,
          )),
      actions: [],
      backgroundColor: Color(0xff343cb4),
      title: Text(
        title,
        style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      elevation: 0,
    ),
  );
}
