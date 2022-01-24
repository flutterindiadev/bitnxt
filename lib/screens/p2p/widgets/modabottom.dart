import 'dart:convert';

import 'package:bitnxt/constants/config.dart';
import 'package:bitnxt/global_widgets/globalButton.dart';
import 'package:bitnxt/models/usermodel.dart';
import 'package:bitnxt/utils/appurl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void showModal(
  BuildContext context,
  TextEditingController buyAmountController,
  TextEditingController sellAmountController,
  TextEditingController buyPriceController,
  TextEditingController sellPriceController,
  String availableINR,
  String availableUsdt,
) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(10),
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
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                        child: Text('SELL',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)))
                  ]),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2 - 30,
                    child: TabBarView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Form(
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                Text(availableINR,
                                    style:
                                        const TextStyle(color: Colors.white)),
                                const Text(
                                  'Limit Order',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        controller: buyPriceController,
                                        decoration: const InputDecoration(
                                            hintText: 'Enter BUY Price',
                                            hintStyle:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: Icon(Icons.add,
                                              color: Colors.white)),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: SizedBox(
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
                                  style: const TextStyle(color: Colors.white),
                                  controller: buyAmountController,
                                  decoration: const InputDecoration(
                                      hintText: 'Enter Amount',
                                      hintStyle:
                                          TextStyle(color: Colors.white)),
                                ),
                                TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                      hintText: '0.00',
                                      hintStyle:
                                          TextStyle(color: Colors.white)),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                GradientButtonFb2(
                                    onPressed: () async {
                                      final userdata =
                                          Provider.of<UserProvider>(context,
                                              listen: false);
                                      Map data = {
                                        "type": "BUY",
                                        "price": buyPriceController.text,
                                        "amount": buyAmountController.text,
                                        "pair": "VC_USDT/VC_INR",
                                        "currency1AccountId": userdata
                                            .user.currencyData['usdtid'],
                                        "currency2AccountId":
                                            userdata.user.currencyData['inrid']
                                      };
                                      final response = await http.post(
                                          Uri.parse(AppUrl.tradeUrl),
                                          body: json.encode(data),
                                          headers: {
                                            "content-Type": "application/json",
                                            "X-Api-Key": API_KEY
                                          });
                                      print(response.body);
                                    },
                                    text: 'BUY')
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Form(
                            child: Column(
                              children: [
                                Text(availableUsdt,
                                    style:
                                        const TextStyle(color: Colors.white)),
                                const Text(
                                  'Limit Order',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        controller: sellPriceController,
                                        decoration: const InputDecoration(
                                            hintText: 'Enter SELL Price',
                                            hintStyle:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: Icon(Icons.add,
                                              color: Colors.white)),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: SizedBox(
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
                                  controller: sellAmountController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                      hintText: 'Enter Amount',
                                      hintStyle:
                                          TextStyle(color: Colors.white)),
                                ),
                                TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                      hintText: '0.00',
                                      hintStyle:
                                          TextStyle(color: Colors.white)),
                                ),
                                GradientButtonFb2(
                                    onPressed: () async {
                                      final userdata =
                                          Provider.of<UserProvider>(context,
                                              listen: false);
                                      Map data = {
                                        "type": "SELL",
                                        "price": sellPriceController.text,
                                        "amount": sellAmountController.text,
                                        "pair": "VC_USDT/VC_INR",
                                        "currency1AccountId": userdata
                                            .user.currencyData['usdtid'],
                                        "currency2AccountId":
                                            userdata.user.currencyData['inrid']
                                      };
                                      final response = await http.post(
                                          Uri.parse(AppUrl.tradeUrl),
                                          body: json.encode(data),
                                          headers: {
                                            "content-Type": "application/json",
                                            "X-Api-Key": API_KEY
                                          });
                                      print(response.body);
                                    },
                                    text: 'SELL')
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
}
