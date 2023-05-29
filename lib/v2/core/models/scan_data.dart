/// Class that handles the data that is scanned from
/// QR Code.
class ScanData {
  /// [String] variable that stores the platform name
  String platform;

  /// [String] variable that stores the request key for the transaction
  String keyId;

  /// Main [Constructor] that accepts that platform name and request key and returns
  /// [ScanData] object.
  ScanData({required this.platform, required this.keyId});

  /// Named [Constructor] that accepts data member in JSON format and returns
  /// [ScanData] object.
  ScanData.fromJson(Map<String, dynamic> json)
      : platform = json['platform'],
        keyId = json['keyId'];

  /// [Function] that converts data members to JSON format.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['platform'] = this.platform;
    data['keyId'] = this.keyId;
    return data;
  }
}
