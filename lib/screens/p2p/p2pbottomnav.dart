import 'package:bitnxt/global_widgets/myappbar.dart';
import 'package:bitnxt/screens/p2p/closedorders.dart';
import 'package:bitnxt/screens/p2p/p2pscreen.dart';
import 'package:flutter/material.dart';

class P2pBottomNavbar extends StatefulWidget {
  const P2pBottomNavbar({Key? key}) : super(key: key);

  static const routename = 'p2pbottom';

  @override
  State<P2pBottomNavbar> createState() => _P2pBottomNavbarState();
}

class _P2pBottomNavbarState extends State<P2pBottomNavbar> {
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
        return const P2pScreen();
      case 1:
        return const ClosedOrdersScreen();
      case 2:
      // return const WalletScreen();
      case 3:
      // return const MyProfileScreen();
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
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.swap_vert),
              label: 'Trades',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: 'My Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Trade History',
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
