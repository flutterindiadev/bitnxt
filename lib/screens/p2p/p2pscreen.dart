import '../../constants/config.dart';
import '../../global_widgets/myappbar.dart';
import 'p2pordermatchscreen.dart';
import '../../utils/appurl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class P2pScreen extends StatefulWidget {
  const P2pScreen({Key? key}) : super(key: key);

  static const routename = 'p2p';

  @override
  State<P2pScreen> createState() => _P2pScreenState();
}

class _P2pScreenState extends State<P2pScreen> {
  TextEditingController sellPriceController = TextEditingController();
  TextEditingController sellAmountController = TextEditingController();
  TextEditingController buyAmountController = TextEditingController();
  TextEditingController buyPriceController = TextEditingController();

  Future placeSellOrder() async {
    Response response;
    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['X-Api-Key'] = API_KEY;
    response = await dio.post(AppUrl.tradeUrl, data: {
      "type": "SELL",
      "price": sellPriceController.text,
      "amount": sellAmountController.text,
      "pair": "VC_USD/VC_INR",
      "currency1AccountId": 0,
      "currency2AccountId": 0
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('Peer to Peer (P2P)', context),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width / 2.2,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Volume',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text('Buy Price', style: TextStyle(color: Colors.white))
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.78,
                      child: ListView.builder(
                        itemCount: 2,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            color: Colors.green[100],
                            height: 50,
                            width: 100,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('0.00',
                                      style:
                                          const TextStyle(color: Colors.black)),
                                  Text('0.00',
                                      style: TextStyle(
                                          color: Colors.green[900],
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width / 2.2,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Sell Price',
                            style: TextStyle(color: Colors.white)),
                        Text('Volume', style: TextStyle(color: Colors.white))
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.78,
                      child: ListView.builder(
                        itemCount: 2,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            color: Colors.red[100],
                            height: 50,
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('0.00',
                                      style:
                                          const TextStyle(color: Colors.black)),
                                  Text('0.00',
                                      style: TextStyle(
                                          color: Colors.red[900],
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(P2pOrderMatchScreen.routename);
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width / 2 - 30,
                decoration: ShapeDecoration(
                  shape: StadiumBorder(),
                  color: Color(0xffDDD601),
                ),
                child: Center(child: Text('My orders')),
              ),
            ),
          ),
          InkWell(
            onTap: () {
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
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Tab(
                                    child: Text('SELL',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)))
                              ]),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 2 - 30,
                                child: TabBarView(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Form(
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 10),
                                            Text('0.00',
                                                style: const TextStyle(
                                                    color: Colors.white)),
                                            const Text(
                                              'Limit Order',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                    // controller: priceController,
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText:
                                                                'Enter BUY Price',
                                                            hintStyle: TextStyle(
                                                                color: Colors
                                                                    .white)),
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
                                              keyboardType:
                                                  TextInputType.number,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              // controller: amountController,
                                              decoration: const InputDecoration(
                                                  hintText: 'Enter Amount',
                                                  hintStyle: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                            TextFormField(
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              decoration: const InputDecoration(
                                                  hintText: '0.00',
                                                  hintStyle: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            ElevatedButton(
                                                onPressed: () {},
                                                child: const Text('BUY'))
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Form(
                                        child: Column(
                                          children: [
                                            Text('0.00',
                                                style: const TextStyle(
                                                    color: Colors.white)),
                                            const Text(
                                              'Limit Order',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                    // controller: priceController,
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText:
                                                                'Enter SELL Price',
                                                            hintStyle: TextStyle(
                                                                color: Colors
                                                                    .white)),
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
                                              // controller: amountController,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              decoration: const InputDecoration(
                                                  hintText:
                                                      'Enter Amount Price',
                                                  hintStyle: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                            TextFormField(
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              decoration: const InputDecoration(
                                                  hintText: '0.00',
                                                  hintStyle: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                            ElevatedButton(
                                                onPressed: () {},
                                                child: const Text('SELL'))
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
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width / 2 - 30,
                decoration: ShapeDecoration(
                  shape: StadiumBorder(),
                  color: Color(0xffDDD601),
                ),
                child: Center(child: Text('Place Order')),
              ),
            ),
          )
        ],
      ),
    );
  }
}
