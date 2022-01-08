import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:bitnxt/constants/config.dart';
import 'package:bitnxt/models/ordermodel.dart';
import 'package:bitnxt/utils/appurl.dart';

class OrderBookScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const OrderBookScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<OrderBookScreen> createState() => _OrderBookScreenState();
}

class _OrderBookScreenState extends State<OrderBookScreen>
    with AutomaticKeepAliveClientMixin {
  List<order> buyOrders = [];
  List<order> sellOrders = [];

  Future<void> getOpenBuys() async {
    String pair1 = widget.data['pair'].toString().substring(0, 3).toUpperCase();
    String pair2 = widget.data['pair'].toString().substring(3, 6).toUpperCase();
    Map data = {"pageSize": 10, "pair": pair1 + '/' + pair2};
    http
        .post(Uri.parse(AppUrl.getBuyOrder),
            headers: {
              "Content-Type": "application/json",
              "X-Api-Key": API_KEY,
            },
            body: json.encode(data))
        .then((response) {
      List parsedJson = json.decode(response.body);
      print(parsedJson);
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
      if (this.mounted) {
        setState(() {
          buyOrders;
        });
      }
    });
  }

  Future<void> getOpenSells() async {
    String pair1 = widget.data['pair'].toString().substring(0, 3).toUpperCase();
    String pair2 = widget.data['pair'].toString().substring(3, 6).toUpperCase();
    Map data = {"pageSize": 10, "pair": pair1 + '/' + pair2};
    http
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
      if (this.mounted) {
        setState(() {
          sellOrders;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getOpenBuys();
    getOpenSells();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        height: 500,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 400,
                width: MediaQuery.of(context).size.width / 2.2,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Volume',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text('Buy Price', style: TextStyle(color: Colors.white))
                      ],
                    ),
                    Container(
                      height: 300,
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
                                  Text('${buyOrders[index].amount}',
                                      style: TextStyle(color: Colors.black)),
                                  Text('${buyOrders[index].price}',
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
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 400,
                width: MediaQuery.of(context).size.width / 2.2,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Sell Price',
                            style: TextStyle(color: Colors.white)),
                        Text('Volume', style: TextStyle(color: Colors.white))
                      ],
                    ),
                    Container(
                      height: 300,
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
                                  Text('${sellOrders[index].price}',
                                      style: TextStyle(color: Colors.black)),
                                  Text('${sellOrders[index].amount}',
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
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
