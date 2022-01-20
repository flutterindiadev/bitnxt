import '../global_widgets/inputfield.dart';
import '../models/coinmodel.dart';
import '../utils/appurl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/usermodel.dart';
import 'register.dart';
import 'package:dio/dio.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Future login() async {
    Response response;
    var dio = Dio();
    response = await dio.post(AppUrl.loginUrl, data: {
      'email': emailController.text,
      'password': passwordController.text
    });
    print(response.data.toString());
  }

  @override
  void initState() {
    Provider.of<CoinData>(context, listen: false).getCoinData().then((_) =>
        Provider.of<UserProvider>(context, listen: false)
            .updateCoinData(context));
    ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: const BoxDecoration(color: Color(0xff17173D)),
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
                  child: EmailInputFieldFb3(
                    isObscure: false,
                    inputController: emailController,
                    icon: const Icon(Icons.email),
                    hint: 'Enter Your Email',
                    inputStyle: TextInputType.emailAddress,
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
                    child: EmailInputFieldFb3(
                      isObscure: true,
                      inputController: passwordController,
                      icon: const Icon(Icons.lock),
                      hint: 'Enter Your Password',
                      inputStyle: TextInputType.visiblePassword,
                    )
                    // TextField(
                    //   style: const TextStyle(fontSize: 16, color: Colors.black87),
                    //   controller: passwordController,
                    //   decoration: InputDecoration(
                    //       fillColor: Colors.white,
                    //       filled: true,
                    //       hintText: 'Enter your Password',
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(10))),
                    //   obscureText: true,
                    // ),
                    ),
                const SizedBox(height: 50),
              ],
            ),
            InkWell(
              onTap: () {
                // login,
                user.login(
                    emailController.text, passwordController.text, context);
              },
              child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.asset('assets/images/login.png')),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RegisterScreen.routename);
                },
                child: const Text('Register Now')),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
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
