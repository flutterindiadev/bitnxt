import 'package:bitnxt/screens/p2p/p2pbottomnav.dart';

import 'screens/p2p/p2pordermatchscreen.dart';
import 'screens/p2p/p2pscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'chart/chartscreen.dart';
import 'models/coinmodel.dart';
import 'models/usermodel.dart';
import 'screens/dashboard/bottomnavbar.dart';
import 'screens/loginscreen.dart';
import 'screens/register.dart';
import 'screens/trade/navbar.dart';
import 'screens/walletscreen/depositscreen.dart';
import 'screens/walletscreen/singlewallet.dart';
import 'screens/walletscreen/walletscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
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
          canvasColor: const Color(0xff17173D),
        ),
        // home: const home(),
        initialRoute: '/',
        routes: {
          '/': (ctx) => const LoginScreen(),
          // candleStickChart.routename: (ctx) => candleStickChart(),
          // Dash.routename: (ctx) => Dash(),
          RegisterScreen.routename: (ctx) => const RegisterScreen(),
          WalletScreen.routename: (ctx) => const WalletScreen(),
          DepositScreen.routename: (ctx) => const DepositScreen(),
          SingleWalletScreen.routename: (ctx) => const SingleWalletScreen(),
          BottomNav.routename: (ctx) => const BottomNav(),
          ChartScreen.routename: (ctx) => const ChartScreen(
                data: {},
              ),
          BottomNavbar.routename: (ctx) => const BottomNavbar(),
          P2pScreen.routename: (ctx) => const P2pScreen(),
          P2pOrderMatchScreen.routename: (ctx) => const P2pOrderMatchScreen(),
          P2pBottomNavbar.routename: (ctx) => const P2pBottomNavbar()
        },
      ),
    );
  }
}
