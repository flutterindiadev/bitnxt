import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bitnxt/models/usermodel.dart';
import 'package:bitnxt/screens/register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: BoxDecoration(color: Color(0xff17173D)),
      ),
      SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 31),
                  child: Text(
                    "User Name",
                    style: TextStyle(
                        fontSize: 14, color: Theme.of(context).primaryColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                  ),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                    controller: emailController,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Enter your User Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 31),
                  child: Text(
                    "Password",
                    style: TextStyle(
                        fontSize: 14, color: Theme.of(context).primaryColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextField(
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                    controller: passwordController,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Enter your Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
            GestureDetector(
              onTap: () {
                user.login(
                    emailController.text, passwordController.text, context);
              },
              child: Container(
                  height: 50,
                  width: 50,
                  child: Image.asset('assets/images/login.png')),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RegisterScreen.routename);
                },
                child: Text('Register Now')),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: 300,
                  width: 300,
                  child: Image.asset(
                    'assets/images/logins.png',
                  )),
            )
          ],
        ),
      )
    ]));
  }
}
