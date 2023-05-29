class BankModel {
  String? userID;
  String? bankAccount;
  String? updatedAt;
  String? createdAt;
  String? uuid;
  String? bankName;
  bool? isMainAccount;
  BankModel();
  BankModel.fromJSON(Map json) {
    userID = json["user_id"];
    bankAccount = json["bank_account_number"];
    updatedAt = json["updatedAt"];
    createdAt = json["createdAt"];
    uuid = json["uuid"];
    bankName = json["bank_name"];
    isMainAccount = json["is_main_account"];
  }
  toJSON() {
    return {
      "user_id": userID,
      "bank_account_number": bankAccount,
      "updatedAt": updatedAt,
      "createdAt": createdAt,
      "uuid": uuid,
      "bank_name": bankName,
      "is_main_account": isMainAccount
    };
  }
}
