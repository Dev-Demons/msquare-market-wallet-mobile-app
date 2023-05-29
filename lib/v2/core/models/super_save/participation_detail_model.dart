class ParticipationDetailModel {
  List? superSaveRequest;

  int? nbElements;
  int? nbTotalElements;
  bool? hasNext;
  ParticipationDetailModel.fromJSON(Map json) {
    superSaveRequest = json['superSaveReq'];

    nbElements = json['nbElements'];
    nbTotalElements = json['nbTotalElements'];
    hasNext = json['hasNext'];
  }
}

class ParticipationHistoryModel {
  String? totalPayout;
  String? remainingBalance;
  String? dailyPayout;
  ParticipationHistoryModel.fromJSON(Map json) {
    totalPayout = json['total_payout'];
    remainingBalance = json['remaining_balance'];
    dailyPayout = json['daily_payout'];
  }
}

class SuperSaveModel {
  String? bankAccountNumber;
  String? paymentMethod;
  String? endDate;
  String? registrationNumber;
  int? depositAmountInMSQ;
  String? bankName;
  String? name;
  String? profileImage;
  String? idImage;
  String? identityType;
  String? birthDate;
  String? nationality;
  String? createdAt;
  String? remark;
  String? startDate;
  String? depositTransactionId;
  String? userId;
  String? updatedAt;
  String? phoneNumber;
  int? dailyPayoutAmount;
  int? depositAmountInWon;
  int? paymentPeriod;
  int? status;
  int? totalPayoutAmount;
  int? paymentRate;

  SuperSaveModel.fromJSON(Map json) {
    bankAccountNumber = json['bank_account_number'];
    paymentMethod = json['payment_method'];
    endDate = json['end_date'];
    registrationNumber = json['registration_number'];
    depositAmountInMSQ = json['desosit_amout_in_msq'];
    bankName = json['bank_name'];
    name = json['name'];
    profileImage = json['profile_image'];
    idImage = json['id_image'];
    registrationNumber = json['identity_type'];
    birthDate = json['birth_date'];
    nationality = json['nationality'];
    createdAt = json['createdAt'];
    remark = json['remark'];
    startDate = json['start_date'];
    depositTransactionId = json['deposit_transaction_id'];
    userId = json['user_id'];
    updatedAt = json['updatedAt'];
    phoneNumber = json['phone_number'];
    dailyPayoutAmount = json['daily_payout_amount'];
    depositAmountInWon = json['deposit_amout_in_won'];
    paymentPeriod = json['payment_period'];
    status = json['status'];
    totalPayoutAmount = json['total_payout_amount'];
    paymentRate = json['payment_rate'];
  }
}
