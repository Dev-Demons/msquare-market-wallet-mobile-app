/*class MyAppUser {
  Userr? userr;

  MyAppUser({this.userr});

  MyAppUser.fromJson(Map<String, dynamic> json) {
    userr = json['user'] != null ? new Userr.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userr != null) {
      data['user'] = this.userr!.toJson();
    }
    return data;
  }
}

class Userr {
  Prices? prices;
  Wallet? wallet;
  String? id;
  String? name;
  String? email;

  Userr({this.prices, this.wallet, this.id, this.name, this.email});

  Userr.fromJson(Map<String, dynamic> json) {
    prices =
        json['prices'] != null ? new Prices.fromJson(json['prices']) : null;
    wallet =
        json['wallet'] != null ? new Wallet.fromJson(json['wallet']) : null;
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.prices != null) {
      data['prices'] = this.prices!.toJson();
    }
    if (this.wallet != null) {
      data['wallet'] = this.wallet!.toJson();
    }
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}

class Wallet {
  Tokens? tokens;
  String? onChainAddress;
  String? nonChainAddress;

  Wallet({this.tokens, this.onChainAddress, this.nonChainAddress});

  Wallet.fromJson(Map<String, dynamic> json) {
    tokens =
        json['tokens'] != null ? new Tokens.fromJson(json['tokens']) : null;
    onChainAddress = json['address'];
    nonChainAddress = json['msqaddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tokens != null) {
      data['tokens'] = this.tokens!.toJson();
    }
    data['address'] = this.onChainAddress;
    data['msqaddress'] = this.nonChainAddress;
    return data;
  }
}

class Tokens {
  double? mSQX;
  double? mSQP;
  double? mSQ;
  double? p2Up;
  double? mSQXP;
  double? mATIC;

  Tokens({this.mSQX, this.mSQP, this.mSQ, this.p2Up, this.mSQXP, this.mATIC});

  Tokens.fromJson(Map<String, dynamic> json) {
    mSQX = double.parse(json['MSQX'].toString());
    mSQP = double.parse(json['MSQP'].toString());
    mSQ = double.parse(json['MSQ'].toString());
    p2Up = double.parse(json['P2UP'].toString());
    mSQXP = double.parse(json['MSQXP'].toString());
    mATIC = double.parse(json['MATIC'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MSQX'] = this.mSQX;
    data['MSQP'] = this.mSQP;
    data['MSQ'] = this.mSQ;
    data['P2UP'] = this.p2Up;
    data['MSQXP'] = this.mSQXP;
    data['MATIC'] = this.mATIC;
    return data;
  }
}

///Added ............................
class Prices {
  String? status;
  PriceToken? tokens;

  Prices({this.status, this.tokens});

  Prices.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    tokens =
        json['tokens'] != null ? new PriceToken.fromJson(json['tokens']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.tokens != null) {
      data['tokens'] = this.tokens!.toJson();
    }
    return data;
  }
}

class PriceToken {
  MSQ? mSQ;
  MSQX? mSQX;
  MATIC? mATIC;
  MSQP? mSQP;
  MSQXP? mSQXP;

  PriceToken({this.mSQ, this.mSQX, this.mATIC});

  PriceToken.fromJson(Map<String, dynamic> json) {
    mSQ = json['MSQ'] != null ? new MSQ.fromJson(json['MSQ']) : null;
    mSQX = json['MSQX'] != null ? new MSQX.fromJson(json['MSQX']) : null;
    mATIC = json['MATIC'] != null ? new MATIC.fromJson(json['MATIC']) : null;
    mSQP = json['MSQP'] != null ? new MSQP.fromJson(json['MSQP']) : null;
    mSQXP = json['MSQXP'] != null ? new MSQXP.fromJson(json['MSQXP']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mSQ != null) {
      data['MSQ'] = this.mSQ!.toJson();
      data['MSQX'] = this.mSQX!.toJson();
      data['MATiC'] = this.mATIC!.toJson();
      data['MSQP'] = this.mSQP!.toJson();
      data['MSQXP'] = this.mSQXP!.toJson();
    }
    return data;
  }
}

class MSQ {
  double? price;
  String? dayChgSign;
  String? dayChgRate;

  MSQ({this.price, this.dayChgSign, this.dayChgRate});

  MSQ.fromJson(Map<String, dynamic> json) {
    price = json['price'] ?? 0.0;
    dayChgSign = json['dayChgSign'];
    dayChgRate = json['dayChgRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['dayChgSign'] = this.dayChgSign;
    data['dayChgRate'] = this.dayChgRate;
    return data;
  }
}

class MSQX {
  double? price;
  String? dayChgSign;
  String? dayChgRate;

  MSQX({this.price, this.dayChgSign, this.dayChgRate});

  MSQX.fromJson(Map<String, dynamic> json) {
    price = json['price'] ?? 0.0;
    dayChgSign = json['dayChgSign'];
    dayChgRate = json['dayChgRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['dayChgSign'] = this.dayChgSign;
    data['dayChgRate'] = this.dayChgRate;
    return data;
  }
}

class MATIC {
  double? price;
  String? dayChgSign;
  String? dayChgRate;

  MATIC({this.price, this.dayChgSign, this.dayChgRate});

  MATIC.fromJson(Map<String, dynamic> json) {
    price = double.parse(json['price'].toString() ?? "0.0");
    dayChgSign = json['dayChgSign'] ?? "-";
    dayChgRate = json['dayChgRate'] ?? "0.0";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['dayChgSign'] = this.dayChgSign;
    data['dayChgRate'] = this.dayChgRate;
    return data;
  }
}

class MSQP {
  double? price;
  String? dayChgSign;
  String? dayChgRate;

  MSQP({this.price, this.dayChgSign, this.dayChgRate});

  MSQP.fromJson(Map<String, dynamic> json) {
    price = double.parse(json['price'].toString() ?? "0.0");
    dayChgSign = json['dayChgSign'] ?? "-";
    dayChgRate = json['dayChgRate'] ?? "0.0";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['dayChgSign'] = this.dayChgSign;
    data['dayChgRate'] = this.dayChgRate;
    return data;
  }
}

class MSQXP {
  double? price;
  String? dayChgSign;
  String? dayChgRate;

  MSQXP({this.price, this.dayChgSign, this.dayChgRate});

  MSQXP.fromJson(Map<String, dynamic> json) {
    price = double.parse(json['price'].toString() ?? "0.0");
    dayChgSign = json['dayChgSign'] ?? "-";
    dayChgRate = json['dayChgRate'] ?? "0.0";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['dayChgSign'] = this.dayChgSign;
    data['dayChgRate'] = this.dayChgRate;
    return data;
  }
}*/
