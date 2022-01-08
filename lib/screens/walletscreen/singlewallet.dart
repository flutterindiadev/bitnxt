import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bitnxt/global_widgets/myappbar.dart';
import 'package:bitnxt/models/usermodel.dart';
import 'package:bitnxt/screens/walletscreen/depositscreen.dart';

class SingleWalletScreen extends StatefulWidget {
  const SingleWalletScreen({Key? key}) : super(key: key);

  static const routename = '/mywallet';

  @override
  State<SingleWalletScreen> createState() => _SingleWalletScreenState();
}

class _SingleWalletScreenState extends State<SingleWalletScreen> {
  String address = '';

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      final arg = ModalRoute.of(context)!.settings.arguments as Map;
      print(arg.toString());
      final user = Provider.of<UserProvider>(context, listen: false);
      if (user
              .user
              .currencyData[
                  '${arg['symbol'].toString().toLowerCase() + 'address'}']
              .toString() ==
          null) {
        await Provider.of<UserProvider>(context, listen: false)
            .getDepositAddress(arg['id']);
        String add = Provider.of<UserProvider>(context, listen: false)
            .user
            .currencyData[
                '${arg['symbol'].toString().toLowerCase() + 'address'}']
            .toString();

        if (mounted) {
          setState(() {
            address = add;
          });
        }
      } else {
        final add = Provider.of<UserProvider>(context, listen: false)
            .user
            .currencyData[
                '${arg['symbol'].toString().toLowerCase() + 'address'}']
            .toString();

        if (mounted) {
          setState(() {
            address = add;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    Map routeArgs = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: myAppBar(routeArgs['coinname'].toString(), context),
      body: Container(
        color: Color(0xff17173D),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  routeArgs['coinname'].toString() + ' Deposit Address',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(address,
                    // user.user.currencyData[
                    //     '${routeArgs['coinname'].toString().toLowerCase() + 'address'}'],
                    style: TextStyle(color: Colors.white)),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                DepositScreen.routename,
                                arguments: routeArgs);
                          },
                          child: Text(
                              'Deposit ${routeArgs['coinname'].toString()}')),
                      ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Withdrawls have been disabled temporarily')));
                          },
                          child: Text(
                              'Withdraw ${routeArgs['coinname'].toString()}'))
                    ],
                  ),
                ),
                Divider(),
                Container(
                  height: MediaQuery.of(context).size.height / 2 + 40,
                  child: Column(
                    children: [
                      Text('Transaction History',
                          style: TextStyle(color: Colors.white)),
                      SizedBox(height: 20),
                      Container(
                        height: MediaQuery.of(context).size.height / 2,
                        color: Color(0xff41516a),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
