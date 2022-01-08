import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:bitnxt/global_widgets/mybutton.dart';
import 'package:bitnxt/models/usermodel.dart';
import 'package:bitnxt/screens/walletscreen/walletscreen.dart';
import 'package:bitnxt/utils/appurl.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static const routename = 'register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Map supportedCurrency = {
    "BTC":
        "tpubDEPEak8YDVdeVyEkc3PTbnhsvgxDwYwGgfKFNDQS4Anu4RB3VTnj2HMRjz9H4C6ZWZmG7LGiGK8Sq8YRSSgNKoNMMFHbTaxoqVVVNXoBrRA",
    "ETH":
        "xpub6ExpFkTiJADEa7uK6PD1EnzAGtTvoQsaPf9ZTz2xtd4p8JCQrfJ69jPNAWHQph7joNpeqZPdZJNLRijyY3VA1CF2KZmNuwjzWbMXJhVnYkM",
    "LTC":
        "ttub4gHf91n73xDLrMonRCni7MxRpBrEjpdrr732Rssq5C2Q6kgD2P6HA31HkJpmU3jQjFgacZuveqtDSHEhwLsSmLnmCtNpubgFUL572UUDH6D",
    "BNB": "tbnb1wv4zw3zxhgzrzfghh6xe8fmndvtlq6tw9t4wvm",
    "DOGE":
        "tpubDENLeg2ZwxYJAutb3Y3vjomJytZNXUgGXegAtyK6T1yumthuxJuvG2oUUqMZxq5uiBGCjiDjQoA1TYnrCB7pSCzUnZriCVvAsdv3QwRaPcm",
    "BCH":
        "tpubDFBLfPxgGzt1pzfQmz4xVfeSSEgrHuJiYAWnsN4kj6V47oSoDWz2KSCrGH2nbFiYdjhZWoEre8m996tXBL2JbkmKQ87qv7Qg1E5Yu8b6a4D",
    "ADA":
        "4c482d1d90896fb1f4d51fbcb74340fe9d72de51970624e4f4ef431f27c20b156caf69513117ea45003a27e40922bcff81723cbb159a98928c0a776b930305ba020998a477733953460a60abb614bc103825c9a6104a91c03ad4ece879a8df07ca77d5cb9bd044a7354bbcc8b55dd941b8e9cab150a915e3f68515c6c98734f0",
    "XRP": "rUPD6kBXFa4cjCLJMfRCFA3wzEYMcuCgMB",
    "XLM": "GBJ3YFED6YV4XMTRSWA3SR4OH5YOWI3ELRIHGGQZ5YP7TBBKOFZ5YLEM",
    "MATIC":
        "xpub6DaX7djeWH8BX5LckcqUY8L4eXyyyDVyoN41Ld4oh2xpzLmYs6SFEqaCMpBRc1TExkLg6PuEgRTfxG4aGrCADjTXDFRP1hMRowsDxJ4cirv",
  };

  Future register(email, password) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    http.post(Uri.parse(AppUrl.registerUrl),
        body: {'email': email, 'password': password}).then((response) {
      final parsedJson = json.decode(response.body);
      if (parsedJson['status'] == true) {
        for (var currency in supportedCurrency.entries) {
          user.createUser(
              currency.key, currency.value, parsedJson['user_id'].toString());
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Something went wrong !')));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
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
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                  ),
                  child: TextField(
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                    controller: userNameController,
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 31),
                  child: Text(
                    "Mobile Number",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                  ),
                  child: TextField(
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                    controller: mobileController,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Enter your Mobile Number',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 31),
                  child: Text(
                    "Email ID",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                  ),
                  child: TextField(
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                    controller: emailController,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Enter your Email ID',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 31),
                  child: Text(
                    "Password",
                    style: TextStyle(fontSize: 14, color: Colors.white),
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
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
            GestureDetector(
                onTap: () {
                  register(emailController.text, passwordController.text).then(
                      (value) => Navigator.of(context)
                          .pushNamed(WalletScreen.routename));
                },
                child: MyButton(text: "Register")),
          ],
        ),
      ),
    );
  }
}
