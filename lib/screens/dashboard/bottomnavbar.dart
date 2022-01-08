import 'package:flutter/material.dart';
import 'package:bitnxt/screens/dashboard/dash.dart';
import 'package:bitnxt/screens/market/marketscreen.dart';
import 'package:bitnxt/screens/my.dart';
import 'package:bitnxt/screens/walletscreen/walletscreen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();

  static const routename = '/bottomnavbar';
}

class _BottomNavState extends State<BottomNav> {
  final List<Widget> _widgetOptions = <Widget>[
    Dash(),
    MarketScreen(),
    WalletScreen(),
    MyProfileScreen()
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xff16163c),
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.swap_vert),
              label: 'Market',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: 'Funds',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          // elevation: 5,
          iconSize: 30,
          // unselectedFontSize: 40,
          backgroundColor: Color(0xff0108DD),
          selectedItemColor: Colors.yellowAccent,
          unselectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
