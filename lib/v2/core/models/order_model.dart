class OrdersData {
  /// Order Currency
  String? currency;

  /// Flag to check if order is completed
  bool? isComplete;

  /// Updated TimeStamp
  String? updatedAt;

  /// Order Ask Price
  String? askPrice;

  /// Created Timestamp
  String? createdAt;

  /// Order Amount
  String? amount;

  /// Flag to check Order type is BUY or SELL
  bool? isBuy;

  /// Order ID
  String? id;

  /// Order Created By User
  String? createdBy;

  /// Order Ask Currency
  String? askCurrency;

  /// [Constructor] which accepts all the data members and
  /// returns the [OrdersData] object
  OrdersData({
    this.currency,
    this.isComplete,
    this.updatedAt,
    this.askPrice,
    this.createdAt,
    this.amount,
    this.isBuy,
    this.id,
    this.createdBy,
    this.askCurrency,
  });

  /// A Named [Constructor] which accepts all the data members in Map(JSON) and
  /// returns the [OrdersData] object
  OrdersData.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    isComplete = json['isComplete'];
    updatedAt = json['updatedAt'];
    askPrice = json['askPrice'].toString();
    createdAt = json['createdAt'];
    amount = json['amount'].toString();
    isBuy = json['isBuy'];
    id = json['id'];
    createdBy = json['createdBy'];
    askCurrency = json['askCurrency'];
  }

  /// A named [Constructor] which converts all data members to
  /// Map(JSON)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency'] = this.currency;
    data['isComplete'] = this.isComplete;
    data['updatedAt'] = this.updatedAt;
    data['askPrice'] = this.askPrice;
    data['createdAt'] = this.createdAt;
    data['amount'] = this.amount;
    data['isBuy'] = this.isBuy;
    data['id'] = this.id;
    data['createdBy'] = this.createdBy;
    data['askCurrency'] = this.askCurrency;
    return data;
  }
}
