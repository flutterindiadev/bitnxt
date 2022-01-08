// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:total_exchange/constants/colors_const.dart';
// import 'package:http/http.dart' as http;
// import 'package:total_exchange/screens/candle_chart.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   static const routeName = '/home';

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late Color color;
//   String filterText = 'ETHBTC';
//   List icon = [""];
//   bool isLoading = false;
//   bool isSelected = false;
//   List name = ['Deposit', 'Transfer', 'Withdraw'];
//   List newBanner = [
//     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdL-W-gfduFKcymK1wTB2OSahWUj8E0dfYZaR5QBXCUF56WQArAzbRcG6L4VmXFax1EQ8&usqp=CAU"
//   ];

//   List tickers = [];

//   @override
//   void initState() {
//     // fetchCoin();
//     fetchCoinPrice();
//     super.initState();
//     color = constant.buttonColour;
//   }

//   Future fetchCoinPrice() async {
//     final response = await http
//         .get(Uri.parse('https://api.binance.com/api/v3/ticker/price'));
//     final priceData = json.decode(response.body);
//     setState(() {
//       tickers = priceData;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: constant.screenBaground,
//       body: SingleChildScrollView(
//         physics: ScrollPhysics(),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 10,
//             ),
//             Column(children: [
//               Container(
//                   height: 140,
//                   width: MediaQuery.of(context).size.width,
//                   child: CarouselSlider(
//                       items: newBanner.map((i) {
//                         return Builder(builder: (BuildContext context) {
//                           return Container(
//                             margin: const EdgeInsets.all(6.0),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8.0),
//                               image: DecorationImage(
//                                 image: NetworkImage(i),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           );
//                         });
//                       }).toList(),
//                       options: CarouselOptions(
//                         height: 150.0,
//                         enlargeCenterPage: true,
//                         autoPlay: true,
//                         aspectRatio: 16 / 9,
//                         autoPlayCurve: Curves.fastOutSlowIn,
//                         enableInfiniteScroll: true,
//                         autoPlayAnimationDuration: Duration(seconds: 4),
//                         viewportFraction: 0.9,
//                       ))
//                   // }),
//                   ),
//               SizedBox(
//                 height: 5,
//               ),
//             ]),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                   child: Text(
//                     "Deposit",
//                     style: TextStyle(
//                         color: constant.whicolor,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w700),
//                   ),
//                 ),
//                 Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Container(
//                       height: 120,
//                       width: MediaQuery.of(context).size.width,
//                       child: ListView.builder(
//                         itemCount: name.length,
//                         scrollDirection: Axis.horizontal,
//                         itemBuilder: (context, index) {
//                           return Container(
//                             width: 100,
//                             child: GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   isSelected = !isSelected;
//                                 });
//                               },
//                               child: Card(
//                                 color: constant.whicolor,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10))),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Icon(Icons.dashboard),
//                                     Text(
//                                       name[index],
//                                       style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w500),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     )),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           filterText = 'BTC';
//                         });
//                       },
//                       child: Chip(
//                         label: Text('BTC'),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             filterText = 'ETH';
//                           });
//                         },
//                         child: Chip(label: Text('ETH'))),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         filterText = 'USDT';
//                       });
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8),
//                       child: Chip(label: Text('USDT')),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             isLoading
//                 ? const Center(
//                     child: CircularProgressIndicator(),
//                   )
//                 : Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     child: Container(
//                       height: MediaQuery.of(context).size.height * 0.5,
//                       width: MediaQuery.of(context).size.width,
//                       child: Card(
//                         elevation: 5,
//                         child: Padding(
//                             padding: const EdgeInsets.all(15.0),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text('Pair'),
//                                     Text('Current Price')
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 300,
//                                   child: ListView.builder(
//                                     shrinkWrap: true,
//                                     itemCount: 1,
//                                     itemBuilder:
//                                         (BuildContext context, int index) {
//                                       final filteredTickers = tickers
//                                           .where((ticker) => ticker['symbol']
//                                               .contains(filterText))
//                                           .toList();
//                                       print(filteredTickers);
//                                       return GestureDetector(
//                                         onTap: () {
//                                           Navigator.of(context).pushNamed(
//                                               candleStickChart.routename,
//                                               arguments: filteredTickers[index]
//                                                   ['symbol']);
//                                         },
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text(filteredTickers[index]
//                                                 ['symbol']),
//                                             Text(
//                                                 filteredTickers[index]['price'])
//                                           ],
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             )),
//                       ),
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
