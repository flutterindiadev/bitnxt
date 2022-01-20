import 'newdash.dart';
import 'package:flutter/material.dart';
import 'dash.dart';
import '../market/marketscreen.dart';
import '../my.dart';
import '../walletscreen/walletscreen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();

  static const routename = '/bottomnavbar';
}

class _BottomNavState extends State<BottomNav> {
  // final List<Widget> _widgetOptions = <Widget>[
  //   Dash(gotoMarketScreen),
  //   const MarketScreen(),
  //   const WalletScreen(),
  //   const MyProfileScreen()
  // ];

  int _selectedIndex = 0;

  void gotoMarketScreen() {
    if (mounted) {
      setState(() {
        _selectedIndex = 1;
      });
    }
  }

  void _onItemTapped(int index) {
    if (mounted) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Widget body() {
    switch (_selectedIndex) {
      case 0:
        return Dash(gotoMarketScreen);
      case 1:
        return const MarketScreen();
      case 2:
        return const WalletScreen();
      case 3:
        return const MyProfileScreen();
    }
    return Container();
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
          backgroundColor: const Color(0xff0108DD),
          selectedItemColor: Colors.yellowAccent,
          unselectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
      body: body(),
    );
  }
}
