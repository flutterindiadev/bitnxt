import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../constants/config.dart';
import 'coinmodel.dart';
import '../screens/dashboard/bottomnavbar.dart';
import '../utils/appurl.dart';
import 'package:dio/dio.dart';

class User {
  String id = '';
  String customerId = '';
  String email = '';
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
    'MATIC',
    'USDT'
  ];
  Map currencyData = {};
  String externalId = '';
  num porfolioValue = 0;
}

class DepositTransaction {
  String transHash;
  String transValue;

  DepositTransaction({required this.transHash, required this.transValue});
}

// userid = '619e2b4fbb2ab01b3c95774c'

class UserProvider with ChangeNotifier {
  final User _user = User();

  User get user => _user;

  final List<DepositTransaction> _depositTransactions = [];

  List<DepositTransaction> get depositTransactions {
    return [..._depositTransactions];
  }

  Future<void> createUser(currency, xpub, id) async {
    Map data = {
      "currency": currency,
      "xpub": xpub,
      "customer": {
        "accountingCurrency": "USD",
        "customerCountry": "IN",
        "externalId": id
      }
    };
    final response = http
        .post(Uri.parse(AppUrl.createAccount),
            headers: {
              "Content-Type": "application/json",
              "X-Api-Key": API_KEY,
            },
            body: json.encode(data))
        .then((response) => print(response.body));
    notifyListeners();
  }

  Future<void> login(email, password, context) async {
    final response = await http.post(Uri.parse(AppUrl.loginUrl),
        body: {'email': email, 'password': password});
    final parsedJson = json.decode(response.body);
    if (parsedJson['status'] == true) {
      user.id = parsedJson['user']['id'].toString();
      user.email = parsedJson['user']['email'].toString();

      //get account
      http.get(
          Uri.parse(AppUrl.getAccount + parsedJson['user']['id'].toString()),
          headers: {"X-Api-Key": API_KEY}).then((response) async {
        final responseData = json.decode(response.body);
        user.customerId = responseData['id'];

        //get Exchange Data
        final exResponse = await http.get(
            Uri.parse(
                AppUrl.getExchangeData + responseData['id'] + '?pageSize=10'),
            headers: {
              "X-Api-Key": API_KEY,
            });
        print(responseData['id'] + 'ExchangeData');
        print(exResponse.body);
        if (exResponse.statusCode == 200) {
          final responseData = json.decode(exResponse.body);
          for (var i = 0; i < user.supportedCurrencies.length; i++) {
            String id = '${user.supportedCurrencies[i].toLowerCase() + 'id'}';
            String balance =
                '${user.supportedCurrencies[i].toLowerCase() + 'balance'}';

            for (var j = 0; j < responseData.length; j++) {
              print(responseData[j]['currency']);
              if (responseData[j]['currency'] == 'VC_INR') {
                user.currencyData['inrid'] = responseData[j]['id'];
                user.currencyData['inrbalance'] =
                    responseData[j]['balance']['availableBalance'];
                break;
              } else if (responseData[j]['currency'] ==
                  user.supportedCurrencies[i]) {
                user.currencyData[id] = responseData[j]['id'];
                user.currencyData[balance] =
                    responseData[j]['balance']['availableBalance'];
                break;
              } else {
                user.currencyData[id] = '';
                user.currencyData[balance] = '0';
              }
              break;
            }
          }
          print(user.currencyData.toString());
        }
      });

      notifyListeners();

      Navigator.of(context).pushNamed(BottomNav.routename);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Login Successful !'),
        backgroundColor: Colors.green,
      ));
    }
    notifyListeners();
  }

  // Future getAccount() async {
  //   http.get(Uri.parse(AppUrl.getAccount + user.id),
  //       headers: {"X-Api-Key": API_KEY}).then((response) async {
  //     final responseData = json.decode(response.body);
  //     user.customerId = responseData['id'];
  //   });
  // }

  // Future getExchangeData() async {
  //   final exResponse = await http.get(
  //       Uri.parse(AppUrl.getExchangeData + customerId + '?pageSize=10'),
  //       headers: {
  //         "X-Api-Key": API_KEY,
  //       });
  //   print(customerId + 'ExchangeData');
  //   print(exResponse.body);
  //   if (exResponse.statusCode == 200) {
  //     final responseData = json.decode(exResponse.body);
  //     for (var i = 0; i < user.supportedCurrencies.length; i++) {
  //       String id = '${user.supportedCurrencies[i].toLowerCase() + 'id'}';
  //       String balance =
  //           '${user.supportedCurrencies[i].toLowerCase() + 'balance'}';
  //       for (var j = 0; j < responseData.length; j++) {
  //         if (responseData[j]['currency'] == user.supportedCurrencies[i]) {
  //           user.currencyData[id] = responseData[j]['id'];
  //           user.currencyData[balance] =
  //               responseData[j]['balance']['availableBalance'];
  //           break;
  //         } else {
  //           user.currencyData[id] = '';
  //           user.currencyData[balance] = '0';
  //         }
  //       }
  //     }
  //   }
  //   notifyListeners();
  // }

  Future getPortfolioValue() async {
    Future.delayed(Duration(seconds: 5), () {
      num portVal = 0;
      for (var i = 0; i < user.supportedCurrencies.length; i++) {
        print(user.currencyData[
            user.supportedCurrencies[i].toString().toLowerCase() + 'price']);
        num bal = num.parse(user.currencyData[
                user.supportedCurrencies[i].toString().toLowerCase() +
                    'balance']
            .toString());
        num price = num.parse(user.currencyData[
                user.supportedCurrencies[i].toString().toLowerCase() + 'price']
            .toString());
        portVal += (bal * price);
      }
      user.porfolioValue = portVal;
      notifyListeners();
    });
  }

  Future createDepositAddress(id) async {
    http.post(Uri.parse(AppUrl.createDepositAddress + id + '/address'),
        headers: {
          "X-Api-Key": API_KEY
        }).then((response) => print(response.body));
    notifyListeners();
  }

  Future getDepositAddress(id) async {
    print(id.toString());
    if (id != '') {
      final response = await http.get(
          Uri.parse(AppUrl.createDepositAddress + id + '/address'),
          headers: {"X-Api-Key": API_KEY}).then((response) {
        final responseData = json.decode(response.body);
        print(responseData);
        if (response.statusCode == 200) {
          String address =
              responseData[0]['currency'].toString().toLowerCase() + 'address';
          user.currencyData[address] =
              responseData[(responseData.length - 1)]['address'];
          getDepositHistory(user.currencyData[address]);
          notifyListeners();
        }
      });
    } else {
      return;
    }
  }

  Future getDepositHistory(String address) async {
    http.get(Uri.parse(AppUrl.getDepositHistory + address + '?pageSize=10'),
        headers: {"X-Api-Key": API_KEY}).then((response) {
      final responseData = json.decode(response.body);
      if (responseData.length > _depositTransactions.length) {
        for (var i = 0; i < responseData.length; i++) {
          _depositTransactions.add(DepositTransaction(
              transHash: responseData[i]['transactionHash'],
              transValue: responseData[i]['value']));
        }
      }
      notifyListeners();
    });
  }

  Future updateCoinData(BuildContext context) async {
    // Future.delayed(const Duration(milliseconds: 600), () {
    final coins = Provider.of<CoinData>(context, listen: false);
    for (int i = 0; i < user.supportedCurrencies.length; i++) {
      String name = '${user.supportedCurrencies[i].toLowerCase() + 'name'}';
      String url = '${user.supportedCurrencies[i].toLowerCase() + 'url'}';
      String price = '${user.supportedCurrencies[i].toLowerCase() + 'price'}';
      String change = '${user.supportedCurrencies[i].toLowerCase() + 'change'}';
      String changePercentage =
          '${user.supportedCurrencies[i].toLowerCase() + 'changePercentage'}';
      for (int j = 0; j < coins.coinList.length; j++) {
        if (user.supportedCurrencies[i].toLowerCase() ==
            coins.coinList[j].symbol) {
          user.currencyData[name] = coins.coinList[j].name;
          user.currencyData[url] = coins.coinList[j].imageUrl;
          user.currencyData[price] = coins.coinList[j].price;
          user.currencyData[change] = coins.coinList[j].change;
          user.currencyData[changePercentage] =
              coins.coinList[j].changePercentage;
          break;
        }
      }
    }
    // });
    notifyListeners();
  }
}
