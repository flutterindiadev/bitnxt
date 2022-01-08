import 'package:flutter/material.dart';
import 'package:bitnxt/constants/colors_const.dart';
import 'package:bitnxt/screens/trades/24volume.dart';
import 'package:bitnxt/screens/trades/lossers.dart';
import 'package:bitnxt/screens/trades/top_gainers.dart';
import 'package:bitnxt/screens/trades/volume.dart';

class Trades extends StatefulWidget {
  const Trades({Key? key}) : super(key: key);

  @override
  _TradesState createState() => _TradesState();
}

class _TradesState extends State<Trades> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [constant.buttonColour, constant.buttonColour2]),
            ),
          ),
          automaticallyImplyLeading: false,
          toolbarHeight: 0,
          elevation: 5,
          bottom: TabBar(
            indicator: ShapeDecoration(
                shape: UnderlineInputBorder(),
                gradient: LinearGradient(
                    colors: [constant.blkcolor, constant.whicolor])),
            tabs: [
              Tab(text: "Volume"),
              Tab(text: "Top Gainers"),
              Tab(text: "Lossers"),
              Tab(text: "24Hrs Volume"),
            ],
          ),
        ),
        body: TabBarView(
          children: [volume(), topGainers(), lossers(), VolumeTwentyFour()],
        ),
      ),
    );
  }
}
