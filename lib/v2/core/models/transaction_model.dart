/// Class that handles [TransactionData]
class TransactionData {
  /// Stores the transaction information
  RequestPlatform? requestPlatform;

  /// Main [Constructor] that accepts transaction data and returns
  /// [TransactionData] object.
  TransactionData({this.requestPlatform});

  /// Named [Constructor] that accepts transaction data in JSON format
  /// and returns [TransactionData] object.
  TransactionData.fromJson(Map<String, dynamic> json) {
    requestPlatform = json['request_platform'] != null
        ? new RequestPlatform.fromJson(json['request_platform'])
        : null;
  }

  /// [Function] that convert all data members into JSON format.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.requestPlatform != null) {
      data['request_platform'] = this.requestPlatform!.toJson();
    }
    return data;
  }
}

/// Class that handles transaction data
class RequestPlatform {
  /// [String] variable that stores the transaction status
  String? status;

  /// [String] variable that stores the platform URL
  String? platformUrl;

  /// [String] variable that stores the transaction expiration time
  int? expiration;

  /// [String] variable that stores the user's wallet address
  String? userWallet;

  /// [String] variable that stores the platform URL
  String? platformName;

  /// [String] variable that stores the transaction request key
  String? requestKey;

  /// [String] variable that stores the transaction type
  String? type;

  /// [Transaction] variable that stores the transaction tokens and
  /// wallet address to whom this transaction will be sent.
  Transaction? transaction;

  /// Main [Constructor] that accepts all the data members and returns
  /// the RequestPlatform object.
  RequestPlatform(
      {this.status,
      this.platformUrl,
      this.expiration,
      this.userWallet,
      this.platformName,
      this.requestKey,
      this.type,
      this.transaction});

  /// Named [Constructor] that accepts all the data members in JSON format
  /// and returns the RequestPlatform object.
  RequestPlatform.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    platformUrl = json['platform_url'];
    expiration = json['expiration'];
    userWallet = json['user_wallet'];
    platformName = json['platform_name'];
    requestKey = json['request_key'];
    type = json['type'];
    transaction = json['transaction'] != null
        ? new Transaction.fromJson(json['transaction'])
        : null;
  }

  /// [Function] that converts all data members into JSON format.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['platform_url'] = this.platformUrl;
    data['expiration'] = this.expiration;
    data['user_wallet'] = this.userWallet;
    data['platform_name'] = this.platformName;
    data['request_key'] = this.requestKey;
    data['type'] = this.type;
    if (this.transaction != null) {
      data['transaction'] = this.transaction!.toJson();
    }
    return data;
  }
}

/// Class that handles token involved in QR Transaction
class Transaction {
  /// [Token] that Stores tokens
  Token? tokens;

  /// [String] variable that stores the address to whom the
  /// transaction amount is sent to.
  String? to;

  /// Main [Constructor] that accepts all data members and returns
  /// [Transaction] object.
  Transaction({this.tokens, this.to});

  /// Named [Constructor] that accepts all data members in JSON format
  /// and returns [Transaction] object.
  Transaction.fromJson(Map<String, dynamic> json) {
    tokens = json['tokens'] != null ? new Token.fromJson(json['tokens']) : null;
    to = json['to'];
  }

  /// [Function] that converts all data members into JSON format
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tokens != null) {
      data['tokens'] = this.tokens!.toJson();
    }
    data['to'] = this.to;
    return data;
  }
}

/// Class that handles token information
class Token {
  /// [String] list that stores token names

  List<String?> name = [];

  /// [String] list that stores token amount
  List<String?> amount = [];

  /// Main [Constructor]
  Token();

  /// Named [Constructor] that adds all token in JSON format into lists and return
  /// [Token] object.
  Token.fromJson(Map<String, dynamic> json) {
    for (int i = 0; i < json.length; ++i) {
      name.add(json.keys.elementAt(i).toString());
      amount.add(json.values.elementAt(i).toString());
    }
  }

  /// [Function] that converts all the data members into JSON response.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['amount'] = this.amount;
    return data;
  }
}
