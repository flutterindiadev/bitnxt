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
}

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
  List<Coin> _coinList = [];

  List<Coin> get coinList {
    return [..._coinList];
  }

  List<MarketCoin> _marketData = [];

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
      if (values.length > 0) {
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

  Future getMarketData(String pair) async {
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=${pair}&order=market_cap_desc&per_page=100&page=1&sparkline=false'));
    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.length > 0) {
        if (_marketData.length > 0) {
          _marketData.clear();

          for (int i = 0; i < values.length; i++) {
            if (values[i]['symbol'] != pair) {
              _marketData.add(MarketCoin(
                  name: values[i]['name'],
                  symbol: values[i]['symbol'] + '/' + '${pair}',
                  price: values[i]['current_price'],
                  change: values[i]['price_change_24h'],
                  changePercentage: values[i]['price_change_percentage_24h']));
            }
          }
        } else {
          for (int i = 0; i < values.length; i++) {
            if (values[i]['symbol'] != pair) {
              _marketData.add(MarketCoin(
                  name: values[i]['name'],
                  symbol: values[i]['symbol'] + '/' + '${pair}',
                  price: values[i]['current_price'],
                  change: values[i]['price_change_24h'],
                  changePercentage: values[i]['price_change_percentage_24h']));
            }
          }
        }
      }
    }
    notifyListeners();
  }
}
