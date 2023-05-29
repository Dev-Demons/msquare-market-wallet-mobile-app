/// Class that handles transactions that we receive in [HistoryScreen]

class HistoryResponse {
  /// [String] variable that stores the msg received in response
  String? msg;

  /// List of [Transactions] that stores the transaction received from
  /// the get_transactions API
  List<Transactions>? transactions;

  /// [String] variable that stores the lastId of the response that
  /// is to be used for lazy loading
  String? lastId;

  int? createdAt;

  /// Main [Constructor] that accepts msg, transactions and lastId and
  /// return [HistoryResponse] object.
  HistoryResponse({this.msg, this.transactions, this.lastId, this.createdAt});

  /// Named [Constructor] that accepts JSON format response and returns
  /// [HistoryResponse] object.
  HistoryResponse.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
    lastId = json['lastId']?.toString() ?? null;
    createdAt = json['createdAt'] ?? null;
  }

  /// [Function] that convert all data members to JSON format.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    data['lastId'] = this.lastId;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

/// Class that handles individual transactions
class Transactions {
  /// [String] variable that stores the currency of the transaction
  String? currency;

  /// [String] variable that stores the timestamp on which this transaction
  /// was created
  String? createDate;

  /// [String] variable that stores the username from which transaction is processed.
  String? from;

  /// [String] variable that stores the transaction action
  String? txAction;

  /// [String] variable that stores the transaction amount
  String? amount;

  /// [String] variable that stores the transaction id
  String? uuid;

  /// [String] variable that stores the username to whom transaction is processed.
  String? to;

  /// [String] variable that stores the email of the user
  String? email;

  /// [String] variable that stores the transaction hash key
  String? txHash;

  /// [String] variable that stores the transaction type
  String? type;

  /// Main [Constructor] that accepts all data members and
  /// returns [Transactions] object
  Transactions(
      {this.currency,
      this.createDate,
      this.from,
      this.txAction,
      this.amount,
      this.uuid,
      this.to,
      this.email,
      this.txHash,
      this.type});

  /// Named [Constructor] that accepts data members in JSON format and returns
  /// [Transactions] object.
  Transactions.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    createDate = json['createdAt'];
    from = json['from'];
    txAction = json['tx_action'];
    amount = json['amount'].toString();
    uuid = json['uuid'];
    to = json['to'];
    email = json['email'];
    txHash = json['tx_hash'];
    type = json['type'];
  }

  /// [Function] that converts all the data members into JSON format
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency'] = this.currency;
    data['createdAt'] = this.createDate;
    data['from'] = this.from;
    data['tx_action'] = this.txAction;
    data['amount'] = this.amount;
    data['uuid'] = this.uuid;
    data['to'] = this.to;
    data['email'] = this.email;
    data['tx_hash'] = this.txHash;
    data['type'] = this.type;
    return data;
  }
}
