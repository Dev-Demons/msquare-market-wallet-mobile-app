class SuperSaveDashboardModel {
  String? reserves;
  String? totalParticipationAmount;
  String? remainingAmount;
  double? consumptionRate;
  UserSuperSave? userSuperSave;
  PossibleParticipation? possibleParticipation;
  CompletedParticipation? completedParticipation;
  MyRequestStatus? myRequestStatus;
  TimeSetting? timeSetting;
  SuperSaveDashboardModel.fromJSON(Map json) {
    reserves = json['reserves'].toString();
    totalParticipationAmount = json['total_participation_amount'].toString();
    remainingAmount = json['remaining_amount'].toString();
    consumptionRate = double.parse(json['consumption_rate'].toString());
    userSuperSave = UserSuperSave.fromJSON(json['my_super_save']);
    possibleParticipation =
        PossibleParticipation.fromJSON(json['possible_participation']);
    completedParticipation =
        CompletedParticipation.fromJSON(json['completed_participation']);
    myRequestStatus = MyRequestStatus.fromJSON(json['my_request_status']);
    timeSetting = TimeSetting.fromJSON(json['time_setting']);
  }
}

class UserSuperSave {
  String? remainingBalance;
  String? myDailyPayout;
  double? creditedAmountPercentage;
  UserSuperSave.fromJSON(Map json) {
    remainingBalance = json['remaining_balance'] ?? "0";
    myDailyPayout = json['my_daily_payout'] ?? "0";
    creditedAmountPercentage =
        double.parse(json['credited_amount_percentage'].toString());
  }
}

class PossibleParticipation {
  int? isDisplay;
  String? paymentPeriod;
  String? totalAmountInMSQ;
  String? requestDate;
  String? endDate;
  String? totalAmountInWon;
  String? companyWalletID;
  String? requestID;
  String? message;
  PossibleParticipation.fromJSON(Map json) {
    isDisplay = json['is_display'];
    paymentPeriod = json['payment_period'];
    totalAmountInMSQ = json['total_amount_in_msq'];
    requestDate = json['request_date'];
    endDate = json['end_date'];
    totalAmountInWon = json['total_amount_in_won'];
    companyWalletID = json['company_wallet_id'];
    requestID = json["request_id"];
    message = json['message'];
  }
}

class CompletedParticipation {
  int? isDisplay;
  String? requestCount;
  List<CompletedTransaction> data = [];
  String? message;
  CompletedParticipation.fromJSON(Map json) {
    isDisplay = json['is_display'];
    requestCount = json['request_count'];
    if (json['list'] != []) {
      for (Map item in json['list']) {
        data.add(CompletedTransaction.fromJSON(item));
      }
    } else {
      data = [];
    }
    message = json['message'] ?? "0";
  }
}

class CompletedTransaction {
  String? paymentPeriod;
  String? totalAmountInMSQ;
  String? requestDate;
  int? status;
  String? totalAmountInWon;
  CompletedTransaction.fromJSON(Map json) {
    paymentPeriod = json['payment_period'];
    totalAmountInMSQ = json['total_amount_in_msq'];
    requestDate = json['request_date'];
    status = json['status'];
    totalAmountInWon = json['total_amount_in_won'];
  }
}

class MyRequestStatus {
  int? isParticipate;
  int? status;
  int? isTransactionRegistered;
  MyRequestStatus.fromJSON(Map json) {
    isParticipate = json['is_participated'];
    status = json['status'];
    isTransactionRegistered = json['is_transaction_registered'];
  }
}

class TimeSetting {
  String? startTime;
  String? endTime;
  String? timeZoneDiff;
  bool isAhead = false;
  TimeSetting.fromJSON(Map json) {
    startTime = json['start_time'];
    endTime = json['end_time'];
    String temp = json['timezone'].replaceAll(' ', '');
    isAhead = temp.contains('+');
    timeZoneDiff = temp.split(isAhead ? '+' : '-')[1].split(')')[0];
  }
}
