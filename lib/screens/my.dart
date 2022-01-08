import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bitnxt/global_widgets/myappbar.dart';
import 'package:bitnxt/models/usermodel.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loggedInUser = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: myAppBar('Profile', context),
      body: Center(
        child: Text(
          'Welcome ${loggedInUser.user.customerId}',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
