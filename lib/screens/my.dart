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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
                width: double.infinity,
                child: Card(
                    color: Colors.blue[900],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        'Username : ${loggedInUser.user.email}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    )),
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: Card(
                  color: Colors.blue[900],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text('User Id : ${loggedInUser.user.customerId}',
                        style: const TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: Card(
                    color: Colors.blue[900],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text('Email : ${loggedInUser.user.email}',
                          style: const TextStyle(color: Colors.white)),
                    )),
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: Card(
                    color: Colors.blue[900],
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text('Mobile Number : ',
                          style: TextStyle(color: Colors.white)),
                    )),
              ),
              const Divider(),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: Card(
                    color: Colors.blue[900],
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text('KYC : unverified',
                          style: TextStyle(color: Colors.red)),
                    )),
              ),
              const Divider(),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: Card(
                    color: Colors.blue[900],
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text('Invite and Earn',
                          style: TextStyle(color: Colors.white)),
                    )),
              ),
              const Divider(),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: Card(
                    color: Colors.blue[900],
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child:
                          Text('Logout', style: TextStyle(color: Colors.white)),
                    )),
              )
            ],
          ),
        ));
  }
}
