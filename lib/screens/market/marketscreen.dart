import 'dart:async';

import 'package:bitnxt/global_widgets/tabselect.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../global_widgets/myappbar.dart';
import '../../models/coinmodel.dart';
import '../trade/navbar.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({Key? key}) : super(key: key);

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  bool _btcSelected = true;
  bool _ethSelected = false;
  bool _usdSelected = false;
  bool _inrSelected = false;
  String pair = 'btc';
  @override
  void initState() {
    Provider.of<CoinData>(context, listen: false)
        .getMarketData(pair)
        .then((value) {
      Timer.periodic(Duration(seconds: 5), (timer) {
        if (mounted) {
          Provider.of<CoinData>(context, listen: false).getMarketData(pair);
        }
      });
    });

    // Stream<Future<List<MarketCoin>>> getMarketPrices() async* {
    //   yield Provider.of<CoinData>(context, listen: false).getMarketData(pair);
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final markets = Provider.of<CoinData>(context);
    return Scaffold(
      appBar: myAppBar('Markets', context),
      body: Container(
        color: const Color(0xff17173D),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        // markets.getMarketData('btc');
                        setState(() {
                          pair = 'btc';
                          _btcSelected = true;
                          _ethSelected = false;
                          _usdSelected = false;
                          _inrSelected = false;
                        });
                      },
                      child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 4.3,
                          child: Center(
                              child: Text(
                            'BTC',
                            style: TextStyle(
                                color: _btcSelected
                                    ? Theme.of(context).primaryColor
                                    : Colors.white),
                          ))),
                    ),
                    InkWell(
                      onTap: () {
                        // markets.getMarketData('eth');
                        setState(() {
                          pair = 'eth';
                          _btcSelected = false;
                          _ethSelected = true;
                          _usdSelected = false;
                          _inrSelected = false;
                        });
                      },
                      child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 4.3,
                          child: Center(
                              child: Text('ETH',
                                  style: TextStyle(
                                      color: _ethSelected
                                          ? Theme.of(context).primaryColor
                                          : Colors.white)))),
                    ),
                    InkWell(
                      onTap: () {
                        // markets.getMarketData('usd');
                        setState(() {
                          pair = 'usd';
                          _btcSelected = false;
                          _ethSelected = false;
                          _usdSelected = true;
                          _inrSelected = false;
                        });
                      },
                      child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 4.3,
                          child: Center(
                              child: Text('USD',
                                  style: TextStyle(
                                      color: _usdSelected
                                          ? Theme.of(context).primaryColor
                                          : Colors.white)))),
                    ),
                    InkWell(
                      onTap: () {
                        // markets.getMarketData('inr');
                        setState(() {
                          pair = 'inr';
                          _btcSelected = false;
                          _ethSelected = false;
                          _usdSelected = false;
                          _inrSelected = true;
                        });
                      },
                      child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 4.3,
                          child: Center(
                              child: Text('INR',
                                  style: TextStyle(
                                      color: _inrSelected
                                          ? Theme.of(context).primaryColor
                                          : Colors.white)))),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: ListView.builder(
                      itemCount: markets.marketData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            final sym =
                                markets.marketData[index].symbol.split('/');
                            if (markets.marketData[index].symbol
                                .toString()
                                .endsWith('inr')) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Chart not available for the selected pair !')));
                            } else {
                              Navigator.of(context).pushNamed(
                                  BottomNavbar.routename,
                                  arguments: {
                                    'pair': sym[0] + sym[1],
                                    'PageIndex': 0
                                  });
                            }
                          },
                          child: SizedBox(
                            height: 50,
                            width: 100,
                            child: Card(
                              color: const Color(0xff41516a),
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      markets.marketData[index].symbol
                                          .toUpperCase(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    const Spacer(),
                                    if (num.parse(markets
                                            .marketData[index].price
                                            .toStringAsFixed(4)) >=
                                        0.0010)
                                      Text(
                                          markets.marketData[index].price
                                              .toStringAsFixed(4),
                                          style: const TextStyle(
                                              color: Colors.white)),
                                    if (num.parse(markets
                                                .marketData[index].price
                                                .toStringAsFixed(8)) >=
                                            0.00000010 &&
                                        num.parse(markets
                                                .marketData[index].price
                                                .toStringAsFixed(4)) <
                                            0.0010)
                                      Text(
                                          markets.marketData[index].price
                                              .toStringAsFixed(8),
                                          style: const TextStyle(
                                              color: Colors.white)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    if (markets.marketData[index]
                                            .changePercentage >
                                        0)
                                      Text(
                                        '+ ' +
                                            markets.marketData[index]
                                                .changePercentage
                                                .toStringAsFixed(4) +
                                            '%',
                                        style: const TextStyle(
                                            color: Colors.green),
                                      ),
                                    if (markets.marketData[index]
                                            .changePercentage <
                                        0)
                                      Text(
                                        markets.marketData[index]
                                                .changePercentage
                                                .toStringAsFixed(4) +
                                            '%',
                                        style:
                                            const TextStyle(color: Colors.red),
                                      )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
