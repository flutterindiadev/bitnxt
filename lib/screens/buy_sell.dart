// import 'package:flutter/material.dart';
// import 'package:total_exchange/global_widgets/mybutton.dart';

// class BuyAndSellScreen extends StatefulWidget {
//   const BuyAndSellScreen({Key? key}) : super(key: key);

//   static const routename = 'buy-sell';

//   @override
//   _BuyAndSellScreenState createState() => _BuyAndSellScreenState();
// }

// class _BuyAndSellScreenState extends State<BuyAndSellScreen> {
//   List<Candle> candles = [];

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         color: Colors.white,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "BTC/USDT",
//                   style: TextStyle(
//                       fontSize: 30,
//                       color: Colors.white60,
//                       fontWeight: FontWeight.w700),
//                 ),
//                 Text(
//                   candles.last.close.toString(),
//                   //
//                   //     :,
//                   style: TextStyle(
//                       fontSize: 20,
//                       color: candles.last.low.toString() ==
//                               candles.last.close.toString()
//                           ? Colors.green
//                           : Colors.red,
//                       fontWeight: FontWeight.w700),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             GestureDetector(
//                 onTap: () {},
//                 child: MyButton(
//                   text: "Buy / Sell",
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
