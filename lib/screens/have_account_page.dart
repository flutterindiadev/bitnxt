import 'package:flutter/material.dart';
import 'package:bitnxt/global_widgets/mybutton.dart';
import 'package:bitnxt/screens/loginscreen.dart';
import 'package:bitnxt/screens/register.dart';

class HaveAccount extends StatefulWidget {
  const HaveAccount({Key? key}) : super(key: key);

  @override
  _HaveAccountState createState() => _HaveAccountState();
}

class _HaveAccountState extends State<HaveAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/start.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            children: [
              // Image.asset("assets/images/1234.png"),
              SizedBox(
                height: 500,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: MyButton(
                        text: "Sign In",
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                      },
                      child: MyButton(
                        text: "Register",
                      )),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}