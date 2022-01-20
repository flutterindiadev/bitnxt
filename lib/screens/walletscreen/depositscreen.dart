import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../constants/config.dart';
import '../../global_widgets/myappbar.dart';
import '../../models/usermodel.dart';
import '../../utils/appurl.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({Key? key}) : super(key: key);

  static const routename = 'deposit';

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  @override
  void initState() {
    // Provider.of<UserProvider>(context, listen: false).getDepositAddress();
    Future.delayed(Duration.zero).then((value) {
      final arg = ModalRoute.of(context)!.settings.arguments as Map;
      Provider.of<UserProvider>(context, listen: false)
          .getDepositAddress(arg['id']);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map routeArg = ModalRoute.of(context)!.settings.arguments as Map;
    final deposits = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: myAppBar('Deposit ${routeArg['coinname'].toString()}', context),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: const Color(0xff17173D),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  '${routeArg['coinname'].toString()} Deposit Address',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                const SizedBox(height: 10),
                // Text(deposits.user.currencyData['']),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {},
                    child: const Text('Create deposit address')),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: const Color(0xff41516a),
                    height: MediaQuery.of(context).size.height / 2 + 100,
                    width: double.infinity,
                    child: Column(
                      children: [
                        const Chip(
                            label: Text(
                          'Deposit History',
                          style: TextStyle(color: Colors.white),
                        )),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Text(
                              'TX Hash',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text('Amount',
                                style: TextStyle(color: Colors.white)),
                            Text('Status',
                                style: TextStyle(color: Colors.white))
                          ],
                        ),
                        const Divider(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: ListView.builder(
                            itemCount: deposits.depositTransactions.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        deposits.depositTransactions[index]
                                                .transHash
                                                .substring(0, 5) +
                                            '...' +
                                            deposits.depositTransactions[index]
                                                .transHash
                                                .substring(
                                                    deposits
                                                            .depositTransactions[
                                                                index]
                                                            .transHash
                                                            .length -
                                                        5,
                                                    deposits
                                                        .depositTransactions[
                                                            index]
                                                        .transHash
                                                        .length),
                                        style: const TextStyle(
                                            fontSize: 12,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      Text(
                                        (int.parse(deposits
                                                    .depositTransactions[index]
                                                    .transValue) /
                                                1000000000000000000)
                                            .toStringAsFixed(5),
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Chip(
                                          label: Text(
                                        'Success',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ))
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
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
