class AppUrl {
  static const registerUrl =
      'https://developer.satmatgroup.com/total_exchange/public/api/register';
  static const loginUrl =
      'https://developer.satmatgroup.com/total_exchange/public/api/login';
  static const baseUrl = 'https://api-eu1.tatum.io/v3';
  static const createAccount = baseUrl + '/ledger/account';
  static const getAccount = baseUrl + '/ledger/customer/';
  static const getExchangeData = baseUrl + '/ledger/account/customer/';
  static const tradeUrl = baseUrl + '/trade';
  static const getBuyOrder = baseUrl + '/trade/buy';
  static const getSellOrder = baseUrl + '/trade/sell';
  static const createDepositAddress = baseUrl + '/offchain/account/';
  static const getDepositHistory = baseUrl + '/ethereum/account/transaction/';
  static const getTradeHistory = baseUrl + '/trade/history';
}
