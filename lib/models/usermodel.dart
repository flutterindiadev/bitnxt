import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:bitnxt/constants/config.dart';
import 'package:bitnxt/models/coinmodel.dart';
import 'package:bitnxt/screens/dashboard/bottomnavbar.dart';
import 'package:bitnxt/utils/appurl.dart';

class User {
  String id = '';
  String customerId = '';
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
  User _user = User();

  User get user => _user;

  List<DepositTransaction> _depositTransactions = [];

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

      // await getAccount();
      try {
        http.get(
            Uri.parse(AppUrl.getAccount + parsedJson['user']['id'].toString()),
            headers: {"X-Api-Key": API_KEY}).then((response) async {
          final responseData = json.decode(response.body);
          user.customerId = responseData['id'];
          print(responseData);

          //Exchange data
          final exResponse = await http.get(
              Uri.parse(
                  AppUrl.getExchangeData + user.customerId + '?pageSize=10'),
              headers: {
                "X-Api-Key": API_KEY,
              });
          if (exResponse.statusCode == 200) {
            final responseData = json.decode(exResponse.body);
            for (var i = 0; i < user.supportedCurrencies.length; i++) {
              String id = '${user.supportedCurrencies[i].toLowerCase() + 'id'}';
              String balance =
                  '${user.supportedCurrencies[i].toLowerCase() + 'balance'}';
              for (var j = 0; j < responseData.length; j++) {
                if (responseData[j]['currency'] ==
                    user.supportedCurrencies[i]) {
                  user.currencyData[id] = responseData[j]['id'];
                  user.currencyData[balance] =
                      responseData[j]['balance']['availableBalance'];
                  break;
                } else {
                  user.currencyData[id] = '';
                  user.currencyData[balance] = '0';
                }
              }
            }

            //calculate portfolio value
            num portVal = 0;
            for (var i = 0; i < user.supportedCurrencies.length; i++) {
              print(user.currencyData[
                  user.supportedCurrencies[i].toString().toLowerCase() +
                      'price']);
              num bal = num.parse(user.currencyData[
                      user.supportedCurrencies[i].toString().toLowerCase() +
                          'balance']
                  .toString());
              num price = num.parse(user.currencyData[
                      user.supportedCurrencies[i].toString().toLowerCase() +
                          'price']
                  .toString());
              portVal += (bal * price);
            }
            user.porfolioValue = portVal;
          }
        });
      } catch (e) {
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login Failed ! Plase try again later !')));
      }

      //navigate
      Navigator.of(context).pushNamed(BottomNav.routename);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login Successful !'),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('User not found'),
        backgroundColor: Colors.red,
      ));
    }
    notifyListeners();
  }

  // Future<void> getExchangeData() async {
  //   Map clist = {};
  //   final response = await http.get(
  //       Uri.parse(AppUrl.getExchangeData + user.customerId + '?pageSize=10'),
  //       headers: {
  //         "X-Api-Key": API_KEY,
  //       });
  //   if (response.statusCode == 200) {
  //     final responseData = json.decode(response.body);
  //     for (var i = 0; i < user.supportedCurrencies.length; i++) {
  //       String id = '${user.supportedCurrencies[i].toLowerCase() + 'id'}';
  //       String balance =
  //           '${user.supportedCurrencies[i].toLowerCase() + 'balance'}';
  //       for (var j = 0; j < responseData.length; j++) {
  //         if (responseData[j]['currency'] == user.supportedCurrencies[i]) {
  //           clist[id] = responseData[j]['id'];
  //           clist[balance] = responseData[j]['balance']['availableBalance'];
  //           break;
  //         } else {
  //           clist[id] = '';
  //           clist[balance] = '0';
  //         }
  //       }
  //     }
  //     user.currencyData = clist;
  //     notifyListeners();
  //   }
  // }

  Future createDepositAddress(id) async {
    http.post(Uri.parse(AppUrl.createDepositAddress + id + '/address'),
        headers: {
          "X-Api-Key": API_KEY
        }).then((response) => print(response.body));
    notifyListeners();
  }

  Future getDepositAddress(id) async {
    http.get(Uri.parse(AppUrl.createDepositAddress + id + '/address'),
        headers: {"X-Api-Key": API_KEY}).then((response) {
      final responseData = json.decode(response.body);
      print(responseData);
      String address =
          responseData[0]['currency'].toString().toLowerCase() + 'address';
      user.currencyData[address] =
          responseData[(responseData.length - 1)]['address'];
      getDepositHistory(user.currencyData[address]);
      notifyListeners();
    });
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

  Future getPorfolioValue() async {
    num portVal = 0;
    for (var i = 0; i < user.supportedCurrencies.length; i++) {
      if (user.currencyData.isNotEmpty) {
        num bal = num.parse(user.currencyData[
                user.supportedCurrencies[i].toString().toLowerCase() +
                    'balance']
            .toString());
        num price = num.parse(user.currencyData[
                user.supportedCurrencies[i].toString().toLowerCase() + 'price']
            .toString());
        portVal += (bal * price);
      } else {
        print('Not run');
      }
    }
    user.porfolioValue = portVal;
    notifyListeners();
  }

  Future updateCoinData(BuildContext context) async {
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
    notifyListeners();
  }
}
