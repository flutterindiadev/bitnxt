class order {
  String id;
  int createdTime;
  String amount;
  String price;
  String fill;
  String type;
  String pair;

  order(
      {required this.id,
      required this.createdTime,
      required this.amount,
      required this.price,
      required this.fill,
      required this.pair,
      required this.type});
}
