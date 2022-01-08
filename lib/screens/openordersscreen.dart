import 'package:flutter/material.dart';
import 'package:bitnxt/global_widgets/myappbar.dart';

class MyOpenOrders extends StatelessWidget {
  final Map<String, dynamic> data;
  const MyOpenOrders({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: myAppBar('My Orders'),
      body: Center(
        child: Text(
          'No open orders',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
