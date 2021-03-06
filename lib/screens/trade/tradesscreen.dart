import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constants/config.dart';
import '../../models/ordermodel.dart';
import '../../utils/appurl.dart';

class TradesScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const TradesScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<TradesScreen> createState() => _TradesScreenState();
}

class _TradesScreenState extends State<TradesScreen> {
  List<order> closedTrades = [];

  Future<void> getClosedTrades() async {
    Map routeData = ModalRoute.of(context)!.settings.arguments as Map;
    String tradingPair = routeData['pair'];
    Map data = {
      "pageSize": "10",
      "pair": tradingPair.substring(0, (tradingPair.length - 3)).toUpperCase() +
          '/' +
          tradingPair.substring((tradingPair.length - 3)).toUpperCase(),
    };
    print(tradingPair +
        tradingPair.substring(0, (tradingPair.length - 3)).toUpperCase());
    final response = await http.post(Uri.parse(AppUrl.getTradeHistory),
        headers: {
          "Content-Type": "application/json",
          "X-Api-Key": API_KEY,
        },
        body: json.encode(data));
    print(response.statusCode);
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
    Future.delayed(Duration.zero).then((value) {
      getClosedTrades();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(closedTrades.toString());
    return Scaffold(
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
