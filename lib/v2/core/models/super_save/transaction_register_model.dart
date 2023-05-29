class TransactionRegisterModel {
  String? name;
  String? dob;
  String? contact;
  String? bankName;
  String? bankAccountNumber;
  String? identityType;
  String? nationality;
  String? regNumber;
  String? profileImage;
  String? idImage;

  TransactionRegisterModel();

  addNameDOBContact(String n, String d, String ct) {
    name = n;
    dob = d;
    contact = ct;
  }

  addIdentity(String id) {
    identityType = id;
  }

  addNationReg(String nation, String reg) {
    nationality = nation;
    regNumber = reg;
  }

  addImagesURL(String profile, String id) {
    profileImage = profile;
    idImage = id;
  }

  addBankDetails(String name, String account) {
    bankName = name;
    bankAccountNumber = account;
  }

  toJSON() {
    return {
      "name": name,
      "dob": dob,
      "contact": contact,
      "bankName": bankName,
      "bankAccountNumber": bankAccountNumber,
      "identityType": identityType,
      "nationality": nationality,
      "regNumber": regNumber,
      "profileImage": profileImage,
      "idImage": idImage,
    };
  }
}
