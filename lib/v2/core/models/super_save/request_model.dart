class SuperSaveRequestModel {
  String? name;
  String? dob;
  String? contact;
  int? paymentPeriod;
  int? paymentRate;
  String? paymentMethod;
  int? depositAmountInMSQ;
  int? depositAmountInWon;
  int? totalPayoutAmount;
  int? dailyPayoutAmount;

  String? possibleToParticipate;
  SuperSaveRequestModel(String n, String d, String c) {
    name = n;
    dob = d;
    contact = c;
  }

  addPaymentDetails(
      int pp, int pr, String pm, int dAM, int dAW, int tPA, int dPA) {
    paymentPeriod = pp;
    paymentRate = pr;
    paymentMethod = pm;
    depositAmountInMSQ = dAM;
    depositAmountInWon = dAW;
    totalPayoutAmount = tPA;
    dailyPayoutAmount = dPA;
  }

  toJSON() {
    return {
      "paymentPeriod": paymentPeriod,
      "paymentRate": paymentRate,
      "paymentMethod": paymentMethod,
      "depositAmountInMSQ": depositAmountInMSQ,
      "depositAmountInWon": depositAmountInWon,
      "totalPayoutAmount": totalPayoutAmount,
      "dailyPayoutAmount": dailyPayoutAmount,
      "possibleToParticipate": possibleToParticipate
    };
  }
}
