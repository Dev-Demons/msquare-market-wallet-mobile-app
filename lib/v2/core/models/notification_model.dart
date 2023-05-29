class NotificationResponse {
  String? amountUsd;
  String? amountMsq;
  String? status;
  String? comment;
  String? txId;

  NotificationResponse();

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    amountUsd = json["amount_usd"].toString();
    amountMsq = json["amount_msq"].toString();
    status = json["status"].toString();
    comment = json["comment"].toString();
    txId = json["txId"].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount_usd'] = this.amountUsd;
    data['amount_msq'] = this.amountMsq;
    data['status'] = this.status;
    data['comment'] = this.comment;
    data['txId'] = this.txId;
    return data;
  }
}
