import 'dart:convert';

import 'package:bitnxt/constants/config.dart';
import 'package:bitnxt/global_widgets/myappbar.dart';
import 'package:bitnxt/models/ordermodel.dart';
import 'package:bitnxt/utils/appurl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ClosedOrdersScreen extends StatefulWidget {
  const ClosedOrdersScreen({Key? key}) : super(key: key);

  @override
  State<ClosedOrdersScreen> createState() => _ClosedOrdersScreenState();
}

class _ClosedOrdersScreenState extends State<ClosedOrdersScreen> {
  List<order> closedTrades = [];

  Future<void> getClosedTrades() async {
    Map data = {
      "pageSize": "10",
      "pair": "VC_USDT/VC_INR",
    };
    final response = await http.post(Uri.parse(AppUrl.getTradeHistory),
        headers: {
          "Content-Type": "application/json",
          "X-Api-Key": API_KEY,
        },
        body: json.encode(data));
    if (response.statusCode == 201) {
      final parsedJson = json.decode(response.body);
      for (var i = 0; i < parsedJson.length; i++) {
        print(parsedJson[i]['id'].toString());
        closedTrades.add(order(
            id: parsedJson[i]['id'].toString(),
            createdTime: parsedJson[i]['created'],
            amount: parsedJson[i]['amount'].toString(),
            price: parsedJson[i]['price'].toString(),
            fill: parsedJson[i]['fill'].toString(),
            pair: parsedJson[i]['pair'].toString(),
            type: parsedJson[i]['type'].toString()));
      }
    }
    if (mounted) {
      setState(() {
        closedTrades;
      });
    }
  }

  @override
  void initState() {
    getClosedTrades();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('Trades', context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'TIME',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'PRICE',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'VOLUME',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width - 20,
              child: ListView.builder(
                itemCount: closedTrades.length,
                itemBuilder: (BuildContext context, int index) {
                  bool isbuy = closedTrades[index].type == 'BUY';
                  return Container(
                      color: isbuy ? Colors.green[100] : Colors.red[100],
                      width: MediaQuery.of(context).size.width - 30,
                      height: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              //converted unix timestamp
                              DateFormat.jms()
                                  .format(DateTime.fromMicrosecondsSinceEpoch(
                                      int.parse(closedTrades[index]
                                              .createdTime
                                              .toString()) *
                                          1000))
                                  .toString()
                                  .substring(
                                      0,
                                      DateFormat.jms()
                                              .format(DateTime
                                                  .fromMicrosecondsSinceEpoch(
                                                      int.parse(closedTrades[
                                                                  index]
                                                              .createdTime
                                                              .toString()) *
                                                          1000))
                                              .toString()
                                              .length -
                                          3),
                              style: const TextStyle(color: Colors.black87),
                            ),
                            Text(closedTrades[index].price.toString(),
                                style: TextStyle(
                                    color: isbuy ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                (num.parse(closedTrades[index].fill))
                                    .toStringAsFixed(4),
                                style: const TextStyle(color: Colors.black87))
                          ],
                        ),
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
