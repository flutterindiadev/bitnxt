import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bitnxt/chart/chartscreen.dart';
import 'package:bitnxt/models/coinmodel.dart';
import 'package:bitnxt/models/usermodel.dart';
import 'package:bitnxt/screens/dashboard/bottomnavbar.dart';
import 'package:bitnxt/screens/dashboard/dash.dart';
import 'package:bitnxt/screens/loginscreen.dart';
import 'package:bitnxt/screens/register.dart';
import 'package:bitnxt/screens/navbar.dart';
import 'package:bitnxt/screens/walletscreen/depositscreen.dart';
import 'package:bitnxt/screens/walletscreen/singlewallet.dart';
import 'package:bitnxt/screens/walletscreen/walletscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CoinData(),
        ),
      ],
      child: MaterialApp(
        title: 'BitNext',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
          canvasColor: Color(0xff17173D),
        ),
        // home: const home(),
        initialRoute: '/',
        routes: {
          '/': (ctx) => LoginScreen(),
          // candleStickChart.routename: (ctx) => candleStickChart(),
          Dash.routename: (ctx) => Dash(),
          RegisterScreen.routename: (ctx) => RegisterScreen(),
          WalletScreen.routename: (ctx) => WalletScreen(),
          DepositScreen.routename: (ctx) => DepositScreen(),
          SingleWalletScreen.routename: (ctx) => SingleWalletScreen(),
          BottomNav.routename: (ctx) => BottomNav(),
          ChartScreen.routename: (ctx) => ChartScreen(
                data: {},
              ),
          BottomNavbar.routename: (ctx) => BottomNavbar()
        },
      ),
    );
  }
}
