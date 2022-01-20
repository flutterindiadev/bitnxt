import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Coin {
  Coin({
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.price,
    required this.change,
    required this.changePercentage,
  });

  String name;
  String symbol;
  String imageUrl;
  num price;
  num change;
  num changePercentage;

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
        name: json['name'],
        symbol: json['symbol'],
        imageUrl: json['image'],
        price: json['current_price'],
        change: json['price_change_24h'],
        changePercentage: json['price_change_percentage_24h']);
  }
}

// Future<List<Coin>> getCoinList() async {
//   final response = await http.get(Uri.parse(
//       'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));
//   List<dynamic> parsedListJson = jsonDecode(response.body);
//   List<Coin> coinList =
//       List<Coin>.from(parsedListJson.map((i) => Coin.fromJson(i)));
//   return coinList;
// }

List supportedCurrencies = [
  'BTC',
  'ETH',
  'LTC',
  'BNB',
  'DOGE',
  'BCH',
  'ADA',
  'XRP',
  'XLM',
  'MATIC'
];

class MarketCoin {
  String name;
  String symbol;
  num price;
  num change;
  num changePercentage;
  MarketCoin({
    required this.name,
    required this.symbol,
    required this.price,
    required this.change,
    required this.changePercentage,
  });
}

class CoinData with ChangeNotifier {
  final List<Coin> _coinList = [];

  List<Coin> get coinList {
    return [..._coinList];
  }

  final List<MarketCoin> _marketData = [];

  List<MarketCoin> get marketData {
    return [..._marketData];
  }

  Future getCoinData() async {
    // List coinList = [];
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          _coinList.add(Coin(
              name: values[i]['name'],
              symbol: values[i]['symbol'],
              imageUrl: values[i]['image'],
              price: values[i]['current_price'],
              change: values[i]['price_change_24h'],
              changePercentage: values[i]['price_change_percentage_24h']));
        }
      }
    }
    notifyListeners();
  }

  Future<List<MarketCoin>> getMarketData(String pair) async {
    List<MarketCoin> mk = [];
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=$pair&order=market_cap_desc&per_page=100&page=1&sparkline=false'));
    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.isNotEmpty) {
        if (_marketData.isNotEmpty) {
          _marketData.clear();
          for (int i = 0; i < values.length; i++) {
            if (values[i]['symbol'] != pair) {
              mk.add(MarketCoin(
                  name: values[i]['name'],
                  symbol: values[i]['symbol'] + '/' + pair,
                  price: values[i]['current_price'],
                  change: values[i]['price_change_24h'],
                  changePercentage: values[i]['price_change_percentage_24h']));
            }
          }
          _marketData.addAll(mk);
        } else {
          for (int i = 0; i < values.length; i++) {
            if (values[i]['symbol'] != pair) {
              mk.add(MarketCoin(
                  name: values[i]['name'],
                  symbol: values[i]['symbol'] + '/' + pair,
                  price: values[i]['current_price'],
                  change: values[i]['price_change_24h'],
                  changePercentage: values[i]['price_change_percentage_24h']));
            }
          }
          _marketData.addAll(mk);
        }
      }
    }
    notifyListeners();
    return mk;
  }
}
