import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'package:bitnxt/global_widgets/myappbar.dart';
import 'package:bitnxt/models/coinmodel.dart';
import 'package:bitnxt/models/usermodel.dart';

class Dash extends StatefulWidget {
  const Dash({Key? key}) : super(key: key);

  static const routename = '/dash';
  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
  bool _isLoading = true;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      await Provider.of<CoinData>(context, listen: false).getCoinData();
      await Provider.of<UserProvider>(context, listen: false)
          .updateCoinData(context);
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: myAppBar('Dashboard', context),
      body: _isLoading
          ? Center(
              child: Text(
                'Connecting to exchange ...',
                style: TextStyle(color: Colors.white),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                color: Color(0xff17173D),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'My Porfolio (in USD)',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              Spacer()
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Text(
                                    '${num.parse(user.user.porfolioValue.toString()).toStringAsFixed(2)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                ),
                                Text(
                                  '+ 5.00% ^(24 Hr. Change%)',
                                  style: TextStyle(color: Colors.green),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              Text('My Holdings :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              // Spacer()
                            ],
                          ),
                          SizedBox(
                            height: 200,
                            child: Center(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: user.user.supportedCurrencies.length,
                                itemBuilder: (BuildContext context, int index) {
                                  String coinname = user
                                      .user
                                      .currencyData[user
                                              .user.supportedCurrencies[index]
                                              .toString()
                                              .toLowerCase() +
                                          'name']
                                      .toString();
                                  String price = user
                                      .user
                                      .currencyData[user
                                              .user.supportedCurrencies[index]
                                              .toString()
                                              .toLowerCase() +
                                          'price']
                                      .toString();
                                  String change = user
                                      .user
                                      .currencyData[user
                                              .user.supportedCurrencies[index]
                                              .toString()
                                              .toLowerCase() +
                                          'change']
                                      .toString();
                                  String changePercentage = user
                                      .user
                                      .currencyData[user
                                              .user.supportedCurrencies[index]
                                              .toString()
                                              .toLowerCase() +
                                          'changePercentage']
                                      .toString();
                                  String image = user
                                      .user
                                      .currencyData[user
                                              .user.supportedCurrencies[index]
                                              .toString()
                                              .toLowerCase() +
                                          'url']
                                      .toString();
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Card(
                                      color: Color(0xff343cb4),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  coinname,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  user.user.supportedCurrencies[
                                                      index],
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: 80,
                                                width: 80,
                                                child: Image.network(image)),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  if (num.parse(change) > 0)
                                                    Text(
                                                      '+ ' +
                                                          (num.parse(change))
                                                              .toStringAsFixed(
                                                                  2),
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                    ),
                                                  if (num.parse(change) < 0)
                                                    Text(
                                                      (num.parse(change))
                                                          .toStringAsFixed(2),
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  if (num.parse(
                                                          changePercentage) >
                                                      0)
                                                    Text(
                                                      '${'+ ' + (num.parse(changePercentage)).toStringAsFixed(2) + '%'}',
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                    ),
                                                  if (num.parse(
                                                          changePercentage) <
                                                      0)
                                                    Text(
                                                      '${num.parse(changePercentage).toStringAsFixed(2) + '%'}',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    )
                                                ]),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${price} USD',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                Text('My Favorites',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                Spacer(),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    'View All',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          SizedBox(
                              height: 210,
                              child: Center(
                                  child: Text(
                                'No favorites added',
                                style: TextStyle(color: Colors.white),
                              ))
                              // ListView.builder(
                              //   itemCount: 3,
                              //   itemBuilder: (BuildContext context, int index) {
                              //     return ListTile(
                              //       title: Text(
                              //         'Bitcoin',
                              //         style: TextStyle(color: Colors.white),
                              //       ),
                              //       subtitle: Text(
                              //         user.user.supportedCurrencies[index],
                              //         style: TextStyle(color: Colors.white),
                              //       ),
                              //       trailing: Column(
                              //         children: [
                              //           SizedBox(
                              //             height: 7,
                              //           ),
                              //           Text(
                              //             '46000',
                              //             style: TextStyle(color: Colors.white),
                              //           ),
                              //           Text(
                              //             '+0.05%',
                              //             style: TextStyle(color: Colors.green),
                              //           ),
                              //         ],
                              //       ),
                              //     );
                              //   },
                              // ),
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
