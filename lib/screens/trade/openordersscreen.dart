import 'dart:convert';

import 'package:bitnxt/constants/config.dart';
import 'package:bitnxt/models/ordermodel.dart';
import 'package:bitnxt/models/usermodel.dart';
import 'package:bitnxt/utils/appurl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MyOpenOrders extends StatefulWidget {
  final Map<String, dynamic> data;
  const MyOpenOrders({Key? key, required this.data}) : super(key: key);

  @override
  State<MyOpenOrders> createState() => _MyOpenOrdersState();
}

class _MyOpenOrdersState extends State<MyOpenOrders> {
  List<order> myOrders = [];
  Future getMyOpenOrders() async {
    Map data = {
      "pageSize": "50",
      "customerId": Provider.of<UserProvider>(context, listen: false)
          .user
          .customerId
          .toString()
    };
    final response = await http.post(Uri.parse(AppUrl.getTradeHistory),
        body: json.encode(data),
        headers: {
          "X-Api-Key": API_KEY,
          "Content-Type": "application/json",
        });
    print(response.body);
  }

  @override
  void initState() {
    getMyOpenOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'No open orders',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
