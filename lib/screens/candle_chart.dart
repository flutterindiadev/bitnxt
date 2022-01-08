// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:http/http.dart' as http;
// import 'package:candlesticks/candlesticks.dart';
// import 'package:total_exchange/global_widgets/mybutton.dart';
// import 'package:total_exchange/screens/buy_sell.dart';
// import 'package:total_exchange/screens/my.dart';
// import 'package:total_exchange/screens/trades/trades.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';

// class candleStickChart extends StatefulWidget {
//   const candleStickChart({Key? key}) : super(key: key);

//   static const routename = 'chart';

//   @override
//   _candleStickChartState createState() => _candleStickChartState();
// }

// class _candleStickChartState extends State<candleStickChart> {
//   List<Candle> candles = [];
//   String interval = "1m";

//   WebSocketChannel? _channel;

//   @override
//   void dispose() {
//     if (_channel != null) _channel!.sink.close();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     Future.delayed(Duration.zero, () {
//       // final routeArgs = ModalRoute.of(context)!.settings.arguments;
//       final routeArgs = 'ETHBTC';
//       binanceFetch("15m", routeArgs.toString());
//     });

//     super.initState();
//   }

//   void binanceFetch(String interval, String symbol) {
//     fetchCandles(symbol: symbol, interval: interval).then(
//       (value) => setState(
//         () {
//           this.interval = interval;
//           candles = value;
//         },
//       ),
//     );
//     if (_channel != null) _channel!.sink.close();
//     _channel = WebSocketChannel.connect(
//       Uri.parse('wss://stream.binance.com:9443/ws'),
//     );
//     _channel!.sink.add(
//       jsonEncode(
//         {
//           "method": "SUBSCRIBE",
//           "params": ["${symbol.toLowerCase()}@kline_" + interval],
//           "id": 1
//         },
//       ),
//     );
//   }

//   void updateCandlesFromSnapshot(AsyncSnapshot<Object?> snapshot) {
//     if (snapshot.data != null) {
//       final data = jsonDecode(snapshot.data as String) as Map<String, dynamic>;
//       if (data.containsKey("k") == true &&
//           candles[0].date.millisecondsSinceEpoch == data["k"]["t"]) {
//         candles[0] = Candle(
//             date: candles[0].date,
//             high: double.parse(data["k"]["h"]),
//             low: double.parse(data["k"]["l"]),
//             open: double.parse(data["k"]["o"]),
//             close: double.parse(data["k"]["c"]),
//             volume: double.parse(data["k"]["v"]));
//       } else if (data.containsKey("k") == true &&
//           data["k"]["t"] - candles[0].date.millisecondsSinceEpoch ==
//               candles[0].date.millisecondsSinceEpoch -
//                   candles[1].date.millisecondsSinceEpoch) {
//         candles.insert(
//             0,
//             Candle(
//                 date: DateTime.fromMillisecondsSinceEpoch(data["k"]["t"]),
//                 high: double.parse(data["k"]["h"]),
//                 low: double.parse(data["k"]["l"]),
//                 open: double.parse(data["k"]["o"]),
//                 close: double.parse(data["k"]["c"]),
//                 volume: double.parse(data["k"]["v"])));
//       }
//     }
//   }

//   Future<List<Candle>> fetchCandles(
//       {required String symbol, required String interval}) async {
//     final uri = Uri.parse(
//         "https://api.binance.com/api/v3/klines?symbol=$symbol&interval=$interval&limit=1000");
//     final res = await http.get(uri);
//     return (jsonDecode(res.body) as List<dynamic>)
//         .map((e) => Candle.fromJson(e))
//         .toList()
//         .reversed
//         .toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final routeArgs = ModalRoute.of(context)!.settings.arguments;
//     final routeArgs = 'ETHBTC';
//     return Container(
//       color: Colors.white,
//       height: double.infinity,
//       width: double.infinity,
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             CustomPaint(
//               child: Container(),
//               painter: HeaderCurvedContainer(),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 18.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     routeArgs.toString(),
//                     style: TextStyle(
//                         fontSize: 30,
//                         color: Colors.white60,
//                         fontWeight: FontWeight.w700),
//                   ),
//                   Container(
//                     child: Text(
//                       candles[0].close.toString(),
//                       style: TextStyle(
//                           fontSize: 20,
//                           color: candles[0].close.toString() ==
//                                   candles[0].low.toString()
//                               ? Colors.red
//                               : Colors.green,
//                           fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               color: Colors.green,
//               height: 30,
//               width: MediaQuery.of(context).size.width,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Vol: ${candles[0].volume.toString()}"),
//                     Text("High: ${candles[0].high.toString()}"),
//                     Text("Low: ${candles[0].low.toString()}"),
//                   ],
//                 ),
//               ),
//             ),
//             Center(
//               child: AspectRatio(
//                 aspectRatio: 1,
//                 child: StreamBuilder(
//                   stream: _channel == null ? null : _channel!.stream,
//                   builder: (context, snapshot) {
//                     updateCandlesFromSnapshot(snapshot);
//                     return Candlesticks(
//                       onIntervalChange: (String value) async {
//                         binanceFetch(value, routeArgs.toString());
//                       },
//                       candles: candles,
//                       interval: interval,
//                     );
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Text('Available Funds:')
//           ],
//         ),
//       ),
//     );
//   }
// }

// class HeaderCurvedContainer extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()..color = Colors.black87;
//     Path path = Path()
//       ..relativeLineTo(0, 150)
//       ..quadraticBezierTo(size.width / 2, 150.0, size.width, 150)
//       ..relativeLineTo(0, -150)
//       ..close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
