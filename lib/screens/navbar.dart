import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:bitnxt/chart/chartscreen.dart';
import 'package:bitnxt/constants/config.dart';
import 'package:bitnxt/global_widgets/myappbar.dart';
import 'package:bitnxt/models/usermodel.dart';
import 'package:bitnxt/screens/openordersscreen.dart';
import 'package:bitnxt/screens/orderbook.dart';
import 'package:bitnxt/screens/tradesscreen.dart';
import 'package:bitnxt/utils/appurl.dart';

class BottomNavbar extends StatefulWidget {
  static const routename = '/test';

  const BottomNavbar({Key? key}) : super(key: key);
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  Map<String, dynamic> data = {};
  TextEditingController priceController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  Future<Map<String, dynamic>> getData(context) async {
    return Future.delayed(Duration(seconds: 0),
        () => {'pair': ModalRoute.of(context)!.settings.arguments.toString()});
  }

  Future<void> placeBuyOrder(String price, String amount) async {
    final c =
        Provider.of<UserProvider>(context, listen: false).user.currencyData;
    String tradingPair = ModalRoute.of(context)!.settings.arguments.toString();
    String currencyId1 =
        c['${tradingPair.substring(0, (tradingPair.length - 3)) + 'id'}'];
    String currencyId2 =
        c['${tradingPair.substring((tradingPair.length - 3)) + 'id'}'];

    Map data = {
      "type": "BUY",
      "price": price,
      "amount": amount,
      "pair": tradingPair.substring(0, (tradingPair.length - 3)).toUpperCase() +
          '/' +
          tradingPair.substring((tradingPair.length - 3)).toUpperCase(),
      "currency1AccountId": currencyId1,
      "currency2AccountId": currencyId2
    };
    print(data);
    http
        .post(Uri.parse(AppUrl.tradeUrl),
            headers: {
              "Content-Type": "application/json",
              "X-Api-Key": API_KEY,
            },
            body: json.encode(data))
        .then((reponse) => print(reponse.body));
  }

  Future<void> placeSellOrder(String price, String amount) async {
    final c =
        Provider.of<UserProvider>(context, listen: false).user.currencyData;
    String tradingPair = ModalRoute.of(context)!.settings.arguments.toString();
    String currencyId1 =
        c['${tradingPair.substring(0, (tradingPair.length - 3)) + 'id'}'];
    String currencyId2 =
        c['${tradingPair.substring((tradingPair.length - 3)) + 'id'}'];
    Map data = {
      "type": "SELL",
      "price": price,
      "amount": amount,
      "pair": tradingPair.substring(0, (tradingPair.length - 3)).toUpperCase() +
          '/' +
          tradingPair.substring((tradingPair.length - 3)).toUpperCase(),
      "currency1AccountId": currencyId1,
      "currency2AccountId": currencyId2
    };
    http
        .post(Uri.parse(AppUrl.tradeUrl),
            headers: {
              "Content-Type": "application/json",
              "X-Api-Key": API_KEY,
            },
            body: json.encode(data))
        .then((reponse) => print(reponse.body));
  }

  @override
  void initState() {
    super.initState();
    getData(context).then((values) {
      setState(() {
        data = values;
      });
    });
  }

  int _selectedIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserProvider>(context);
    PageController _pageController = PageController();

    List<Widget> _screens = [
      ChartScreen(data: data),
      OrderBookScreen(data: data),
      TradesScreen(data: data),
      MyOpenOrders(data: data)
    ];

    void onTabTapped(int selectedIndex) {
      _pageController.jumpToPage(selectedIndex);
    }

    return Scaffold(
      appBar: myAppBar((data['pair']).toString().toUpperCase(), context),
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.trending_up,
                ),
                label: 'Chart'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.receipt,
                ),
                label: 'Orderbook'),
            BottomNavigationBarItem(icon: Icon(Icons.refresh), label: 'Trades'),
            BottomNavigationBarItem(
                icon: Icon(Icons.manage_accounts), label: 'My Orders'),
          ],
          iconSize: 30,
          backgroundColor: Color(0xff0108DD),
          selectedItemColor: Colors.yellow,
          unselectedItemColor: Colors.white),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: DefaultTabController(
                      length: 2,
                      initialIndex: 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const TabBar(tabs: <Widget>[
                            Tab(
                              child: Text(
                                'BUY',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Tab(
                                child: Text('SELL',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)))
                          ]),
                          Container(
                            height: MediaQuery.of(context).size.height / 2 - 30,
                            child: TabBarView(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Form(
                                    child: Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Text(
                                            'Available ${data['pair'].toString().substring(0, (data['pair'].toString().length - 3))} : ${userData.user.currencyData['${data['pair'].toString().substring(0, (data['pair'].toString().length - 3))}balance']}',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        Text(
                                          'Limit Order',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                style: TextStyle(
                                                    color: Colors.white),
                                                controller: priceController,
                                                decoration: InputDecoration(
                                                    hintText: 'Enter BUY Price',
                                                    hintStyle: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  child: Icon(Icons.add,
                                                      color: Colors.white)),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                child: Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(color: Colors.white),
                                          controller: amountController,
                                          decoration: InputDecoration(
                                              hintText: 'Enter Amount',
                                              hintStyle: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                        TextFormField(
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                              hintText: '0.00',
                                              hintStyle: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              placeBuyOrder(
                                                  priceController.text,
                                                  amountController.text);
                                            },
                                            child: Text('BUY'))
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Form(
                                    child: Column(
                                      children: [
                                        Text(
                                            'Available ${data['pair'].toString().substring((data['pair'].toString().length - 3))} : ${userData.user.currencyData['${data['pair'].toString().substring((data['pair'].toString().length - 3))}balance']}',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        Text(
                                          'Limit Order',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                style: TextStyle(
                                                    color: Colors.white),
                                                controller: priceController,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        'Enter SELL Price',
                                                    hintStyle: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  child: Icon(Icons.add,
                                                      color: Colors.white)),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                child: Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        TextFormField(
                                          controller: amountController,
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                              hintText: 'Enter Amount Price',
                                              hintStyle: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                        TextFormField(
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                              hintText: '0.00',
                                              hintStyle: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              placeSellOrder(
                                                  priceController.text,
                                                  amountController.text);
                                            },
                                            child: Text('SELL'))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                );
              });
        },
        child: Icon(
          Icons.add_chart,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
