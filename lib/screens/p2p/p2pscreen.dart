import 'dart:convert';

import 'package:bitnxt/models/ordermodel.dart';
import 'package:bitnxt/models/usermodel.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../constants/config.dart';
import '../../global_widgets/myappbar.dart';
import '../../utils/appurl.dart';
import 'package:flutter/material.dart';

class P2pScreen extends StatefulWidget {
  const P2pScreen({Key? key}) : super(key: key);

  static const routename = 'p2p';

  @override
  State<P2pScreen> createState() => _P2pScreenState();
}

class _P2pScreenState extends State<P2pScreen> {
  TextEditingController sellPriceController = TextEditingController();
  TextEditingController sellAmountController = TextEditingController();
  TextEditingController buyAmountController = TextEditingController();
  TextEditingController buyPriceController = TextEditingController();
  List buyOrders = [];
  List sellOrders = [];

  Future getOpenBuyOrders() async {
    Map data = {"pageSize": 50, "pair": "VC_USDT/VC_INR"};
    final response = await http
        .post(Uri.parse(AppUrl.getBuyOrder),
            headers: {
              "Content-Type": "application/json",
              "X-Api-Key": API_KEY,
            },
            body: json.encode(data))
        .then((response) {
      List parsedJson = json.decode(response.body);
      for (var i = 0; i < parsedJson.length; i++) {
        if (parsedJson[i]['type'] == 'BUY') {
          buyOrders.add(order(
              id: parsedJson[i]['id'],
              createdTime: parsedJson[i]['created'],
              amount: parsedJson[i]['amount'],
              price: parsedJson[i]['price'],
              fill: parsedJson[i]['fill'],
              pair: parsedJson[i]['pair'],
              type: parsedJson[i]['type']));
        }
      }
      if (mounted) {
        setState(() {
          buyOrders;
        });
      }
    });
  }

  Future getOpenSellOrders() async {
    Map data = {"pageSize": 50, "pair": "VC_USDT/VC_INR"};
    final response = await http
        .post(Uri.parse(AppUrl.getSellOrder),
            headers: {
              "Content-Type": "application/json",
              "X-Api-Key": API_KEY,
            },
            body: json.encode(data))
        .then((response) {
      List parsedJson = json.decode(response.body);
      print(parsedJson);
      for (var i = 0; i < parsedJson.length; i++) {
        if (parsedJson[i]['type'] == 'SELL') {
          sellOrders.add(order(
              id: parsedJson[i]['id'],
              createdTime: parsedJson[i]['created'],
              amount: parsedJson[i]['amount'],
              price: parsedJson[i]['price'],
              fill: parsedJson[i]['fill'],
              pair: parsedJson[i]['pair'],
              type: parsedJson[i]['type']));
        }
      }
      if (mounted) {
        setState(() {
          sellOrders;
        });
      }
    });
  }

  @override
  void initState() {
    getOpenBuyOrders();
    getOpenSellOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userdata = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: myAppBar('Peer to Peer (P2P)', context),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                width: MediaQuery.of(context).size.width / 2.2,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Volume',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text('Buy Price', style: TextStyle(color: Colors.white))
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.76,
                      child: ListView.builder(
                        itemCount: buyOrders.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            color: Colors.green[100],
                            height: 50,
                            width: 100,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(buyOrders[index].amount,
                                      style:
                                          const TextStyle(color: Colors.black)),
                                  Text(buyOrders[index].price,
                                      style: TextStyle(
                                          color: Colors.green[900],
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width / 2.2,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Sell Price',
                            style: TextStyle(color: Colors.white)),
                        Text('Volume', style: TextStyle(color: Colors.white))
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.76,
                      child: ListView.builder(
                        itemCount: sellOrders.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            color: Colors.red[100],
                            height: 50,
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(sellOrders[index].price,
                                      style:
                                          const TextStyle(color: Colors.black)),
                                  Text(sellOrders[index].amount,
                                      style: TextStyle(
                                          color: Colors.red[900],
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
