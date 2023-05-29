class WithdrawalModel {
  String? reason;
  String? description;
  String? bankName;
  String? bankAccountNumber;
  int? amount;
  WithdrawalModel(String r, String d, String bn, String ba, int a) {
    reason = r;
    description = d;
    bankName = bn;
    bankAccountNumber = ba;
    amount = a;
  }
}
