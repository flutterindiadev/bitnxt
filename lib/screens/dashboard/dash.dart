import '../p2p/p2pscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../global_widgets/myappbar.dart';
import '../../models/usermodel.dart';

class Dash extends StatefulWidget {
  const Dash(
    this.gotoMarketScreen,
  );
  static const routename = '/dash';

  final void Function() gotoMarketScreen;

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).getPortfolioValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: myAppBar('Dashboard', context),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xff17173D),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Text(
                          'My Porfolio (in USD)',
                          style: TextStyle(fontSize: 15, color: Colors.white),
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
                              num.parse(user.user.porfolioValue.toString())
                                  .toStringAsFixed(2),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                          const Text(
                            '+ 5.00% ^(24 Hr. Change%)',
                            style: TextStyle(color: Colors.green),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: const [
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
                                color: const Color(0xff343cb4),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            coinname,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          Text(
                                            user.user
                                                .supportedCurrencies[index],
                                            style: const TextStyle(
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            if (num.parse(change) > 0)
                                              Text(
                                                '+ ' +
                                                    (num.parse(change))
                                                        .toStringAsFixed(2),
                                                style: const TextStyle(
                                                    color: Colors.green),
                                              ),
                                            if (num.parse(change) < 0)
                                              Text(
                                                (num.parse(change))
                                                    .toStringAsFixed(2),
                                                style: const TextStyle(
                                                    color: Colors.red),
                                              ),
                                            if (num.parse(changePercentage) > 0)
                                              Text(
                                                '+ ' +
                                                    (num.parse(
                                                            changePercentage))
                                                        .toStringAsFixed(2) +
                                                    '%',
                                                style: const TextStyle(
                                                    color: Colors.green),
                                              ),
                                            if (num.parse(changePercentage) < 0)
                                              Text(
                                                num.parse(changePercentage)
                                                        .toStringAsFixed(2) +
                                                    '%',
                                                style: const TextStyle(
                                                    color: Colors.red),
                                              )
                                          ]),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '$price USD',
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
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(P2pScreen.routename);
                            },
                            child: Container(
                              decoration: ShapeDecoration(
                                  shape: StadiumBorder(), color: Colors.grey),
                              height: 50,
                              width: MediaQuery.of(context).size.width / 2 - 30,
                              child: Center(child: Text('P2P')),
                            ),
                          ),
                          Container(
                            decoration: ShapeDecoration(
                                shape: StadiumBorder(), color: Colors.grey),
                            height: 50,
                            width: MediaQuery.of(context).size.width / 2 - 30,
                            child: Center(child: Text('Deposit')),
                          )
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          const Text('My Favorites',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          const Spacer(),
                          InkWell(
                            onTap: widget.gotoMarketScreen,
                            child: const Text(
                              'View All',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_right,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    const SizedBox(
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
