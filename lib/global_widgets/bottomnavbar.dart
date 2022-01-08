// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:total_exchange/chart/chartscreen.dart';
// import 'package:total_exchange/constants/config.dart';
// import 'package:total_exchange/global_widgets/myappbar.dart';
// import 'package:total_exchange/screens/orderbook.dart';
// import 'package:total_exchange/utils/appurl.dart';

// class BottomNavbar extends StatefulWidget {
//   const BottomNavbar({Key? key}) : super(key: key);

//   static const routename = '/bottomnav';

//   @override
//   BottomNavbarState createState() => BottomNavbarState();
// }

// class BottomNavbarState extends State<BottomNavbar> {
//   int _pageIndex = 0;
//   late PageController _pageController;
//   TextEditingController priceController = TextEditingController();
//   TextEditingController amountController = TextEditingController();

//   List<Widget> tabPages = [
//     // ChartScreen(),
//     // OrderBookScreen(),
//     // Screen3(),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: _pageIndex);
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   Future<void> placeBuyOrder(String price, String amount) async {
//     Map data = {
//       "type": "BUY",
//       "price": price,
//       "amount": amount,
//       "pair": "ETH/BTC",
//       "currency1AccountId": "61ac96363d94cb8172728a86",
//       "currency2AccountId": "619e2b4fbb2ab0454295774b"
//     };
//     http
//         .post(Uri.parse(AppUrl.tradeUrl),
//             headers: {
//               "Content-Type": "application/json",
//               "X-Api-Key": API_KEY,
//             },
//             body: json.encode(data))
//         .then((reponse) => print(reponse.body));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: myAppBar('BitNext'),
//       floatingActionButton: FloatingActionButton.extended(
//         elevation: 4.0,
//         // icon: const Icon(Icons.add),
//         label: const Text('BUY / SELL'),
//         onPressed: () {
//           showModalBottomSheet<void>(
//               context: context,
//               builder: (BuildContext context) {
//                 return Padding(
//                   padding: EdgeInsets.all(10),
//                   child: DefaultTabController(
//                       length: 2,
//                       initialIndex: 0,
//                       child: Column(
//                         children: [
//                           const TabBar(tabs: <Widget>[
//                             Tab(
//                               child: Text(
//                                 'BUY',
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             Tab(
//                                 child: Text('SELL',
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold)))
//                           ]),
//                           Container(
//                             height: 300,
//                             child: TabBarView(
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.all(10),
//                                   child: Form(
//                                     child: Column(
//                                       children: [
//                                         Text('Limit Order'),
//                                         TextFormField(
//                                           controller: priceController,
//                                           decoration: InputDecoration(
//                                               hintText: 'Enter Buy Price'),
//                                         ),
//                                         TextFormField(
//                                           controller: amountController,
//                                           decoration: InputDecoration(
//                                               hintText: 'Enter Amount'),
//                                         ),
//                                         TextFormField(
//                                           decoration:
//                                               InputDecoration(hintText: '0.00'),
//                                         ),
//                                         SizedBox(
//                                           height: 20,
//                                         ),
//                                         ElevatedButton(
//                                             onPressed: () {
//                                               placeBuyOrder(
//                                                   priceController.text,
//                                                   amountController.text);
//                                             },
//                                             child: Text('BUY'))
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(10),
//                                   child: Form(
//                                     child: Column(
//                                       children: [
//                                         Text('Limit Order'),
//                                         TextFormField(
//                                           decoration: InputDecoration(
//                                               hintText: 'Enter SELL Price'),
//                                         ),
//                                         TextFormField(
//                                           decoration: InputDecoration(
//                                               hintText: 'Enter Amount Price'),
//                                         ),
//                                         TextFormField(
//                                           decoration:
//                                               InputDecoration(hintText: '0.00'),
//                                         ),
//                                         ElevatedButton(
//                                             onPressed: () {},
//                                             child: Text('SELL'))
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       )),
//                 );
//               });
//         },
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: BottomAppBar(
//         // hasNotch: false,
//         child: Padding(
//           padding: EdgeInsets.only(left: 10, right: 10),
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               InkWell(
//                 onTap: () {
//                   setState(() {
//                     _pageIndex = 0;
//                   });
//                 },
//                 child: Container(
//                     height: 50,
//                     child: Column(
//                       children: [Icon(Icons.moving), Text('Chart')],
//                     )),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               InkWell(
//                 onTap: () {
//                   setState(() {
//                     _pageIndex = 1;
//                   });
//                 },
//                 child: Container(
//                     height: 50,
//                     child: Column(
//                       children: [Icon(Icons.equalizer), Text('Market Depth')],
//                     )),
//               ),
//               Spacer(),
//               Container(
//                   height: 50,
//                   child: Column(
//                     children: [Icon(Icons.storefront), Text('Orderbook')],
//                   )),
//               SizedBox(
//                 width: 10,
//               ),
//               Container(
//                   height: 50,
//                   child: Column(
//                     children: [Icon(Icons.person), Text('Profile')],
//                   )),
//             ],
//           ),
//         ),
//       ),
//       body: tabPages[_pageIndex],
//     );
//   }
// }
