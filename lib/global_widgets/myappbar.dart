import 'package:flutter/material.dart';
import 'package:bitnxt/screens/dashboard/bottomnavbar.dart';

PreferredSizeWidget myAppBar(
  String title,
  BuildContext context,
) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(50),
    child: AppBar(
      leading: InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            if (title == 'Dashboard' ||
                title == 'Markets' ||
                title == 'Wallets' ||
                title == 'Profile') {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Already on the Homepage'),
                duration: Duration(seconds: 1),
              ));
            } else {
              Navigator.of(context).pushReplacementNamed(BottomNav.routename);
            }
          },
          child: const Icon(
            Icons.home,
            color: Colors.white,
          )),
      actions: const [],
      backgroundColor: const Color(0xff343cb4),
      title: Text(
        title,
        style:
            const TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      elevation: 0,
    ),
  );
}
