import 'package:flutter/material.dart';

class MyOpenOrders extends StatelessWidget {
  final Map<String, dynamic> data;
  const MyOpenOrders({Key? key, required this.data}) : super(key: key);

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
