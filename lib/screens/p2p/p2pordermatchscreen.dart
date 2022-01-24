import 'package:bitnxt/global_widgets/globalButton.dart';

import '../../global_widgets/myappbar.dart';
import 'package:flutter/material.dart';

class P2pOrderMatchScreen extends StatelessWidget {
  const P2pOrderMatchScreen({Key? key}) : super(key: key);

  static const routename = 'order-matched';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar('Order Matched', context),
      body: Column(
        children: [
          const Text(
            'Your order for 0.00 USDT has been matched',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
              'Please Transfer INR 0.00 to below account and press confirm'),
          const Text('Bank Name : ICICI Bank'),
          const Text('Account Number : 0000000000'),
          const Text('IFSC code : ICIC098726'),
          const Text('UPI : upi@icici'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [GradientButtonFb1(text: 'Confirm', onPressed: () {})],
            ),
          )
        ],
      ),
    );
  }
}
