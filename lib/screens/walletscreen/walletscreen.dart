import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bitnxt/global_widgets/myappbar.dart';
import 'package:bitnxt/models/usermodel.dart';
import 'package:bitnxt/screens/walletscreen/singlewallet.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  static const routename = '/wallet';

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    final userBalances = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: myAppBar('Wallets', context),
      body: Container(
        color: Color(0xff17173D),
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${num.parse(userBalances.user.porfolioValue.toString()).toStringAsFixed(2)}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                'Total Porfolio Value (in USD)',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.60,
                child: ListView.builder(
                  itemCount: userBalances.user.supportedCurrencies.length,
                  itemBuilder: (BuildContext context, int index) {
                    String bal = num.parse(userBalances.user.currencyData[
                            userBalances.user.supportedCurrencies[index]
                                    .toString()
                                    .toLowerCase() +
                                'balance'])
                        .toStringAsFixed(8);
                    String id = userBalances.user.currencyData[userBalances
                            .user.supportedCurrencies[index]
                            .toString()
                            .toLowerCase() +
                        'id'];
                    String image = userBalances.user.currencyData[userBalances
                            .user.supportedCurrencies[index]
                            .toString()
                            .toLowerCase() +
                        'url'];
                    String coinname = userBalances
                        .user
                        .currencyData[userBalances
                                .user.supportedCurrencies[index]
                                .toString()
                                .toLowerCase() +
                            'name']
                        .toString();
                    String price = userBalances
                        .user
                        .currencyData[userBalances
                                .user.supportedCurrencies[index]
                                .toString()
                                .toLowerCase() +
                            'price']
                        .toString();
                    String coinValue =
                        '${(num.parse(bal) * num.parse(price)).toStringAsFixed(2) + ' USD'}';
                    return Card(
                      color: Color(0xff41516a),
                      elevation: 0,
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      SingleWalletScreen.routename,
                                      arguments: {
                                        'id': id,
                                        'coinname': coinname,
                                        'symbol': userBalances
                                            .user.supportedCurrencies[index]
                                      });
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 30,
                                        width: 30,
                                        child: Image.network(image)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userBalances
                                              .user.supportedCurrencies[index],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Text(coinname,
                                            style:
                                                TextStyle(color: Colors.white))
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(bal,
                                            style:
                                                TextStyle(color: Colors.white)),
                                        Text(coinValue,
                                            style:
                                                TextStyle(color: Colors.white))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                            ],
                          )),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
