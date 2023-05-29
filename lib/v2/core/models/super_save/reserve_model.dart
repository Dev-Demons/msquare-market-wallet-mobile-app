class ReserveModel {
  String? bank;
  String? updatedAt;
  String? confirmationDate;
  String? createdAt;
  String? bankCertificateUrl;
  String? id;
  String? accountNumber;
  String? accountBalance;
  ReserveModel.fromJSON(Map json) {
    bank = json["bank"];
    updatedAt = json["updatedAt"];
    confirmationDate = json["confirmationDate"];
    createdAt = json["createdAt"];
    bankCertificateUrl = json["bankCertificateUrl"];
    id = json["id"];
    accountNumber = json["accountNumber"];
    accountBalance = json["accountBalance"].toString();
  }
}
