import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../global_widgets/myappbar.dart';
import '../../models/usermodel.dart';
import 'depositscreen.dart';

class SingleWalletScreen extends StatefulWidget {
  const SingleWalletScreen({Key? key}) : super(key: key);

  static const routename = '/mywallet';

  @override
  State<SingleWalletScreen> createState() => _SingleWalletScreenState();
}

class _SingleWalletScreenState extends State<SingleWalletScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () async {
      Map routeArgs = ModalRoute.of(context)!.settings.arguments as Map;
      await Provider.of<UserProvider>(context, listen: false)
          .getDepositAddress(routeArgs['id']);
    });

    // getAddress = getDepositAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map routeArgs = ModalRoute.of(context)!.settings.arguments as Map;

    final user = Provider.of<UserProvider>(context);
    return Scaffold(
        appBar: myAppBar(routeArgs['coinname'].toString(), context),
        body: Container(
          color: const Color(0xff17173D),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    routeArgs['coinname'].toString() + ' Deposit Address',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                      user.user.currencyData[
                              routeArgs['symbol'].toString().toLowerCase() +
                                  'address'] ??
                          'No deposit address',
                      style: const TextStyle(color: Colors.white)),
                  const Divider(),
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
                            'Deposit ${routeArgs['symbol'].toString()}',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Withdrawls have been disabled temporarily')));
                            },
                            child: Text(
                                'Withdraw ${routeArgs['symbol'].toString()}'))
                      ],
                    ),
                  ),
                  const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2 + 40,
                    child: Column(
                      children: [
                        const Text('Transaction History',
                            style: TextStyle(color: Colors.white)),
                        const SizedBox(height: 20),
                        Container(
                          height: MediaQuery.of(context).size.height / 2,
                          color: const Color(0xff41516a),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
