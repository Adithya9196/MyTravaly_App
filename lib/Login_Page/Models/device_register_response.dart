import 'dart:convert';

DeviceRegister deviceRegisterFromJson(String str) =>
    DeviceRegister.fromJson(json.decode(str));

String deviceRegisterToJson(DeviceRegister data) => json.encode(data.toJson());

class DeviceRegister {
  bool status;
  String message;
  int responseCode;
  Data data;

  DeviceRegister({
    required this.status,
    required this.message,
    required this.responseCode,
    required this.data,
  });

  factory DeviceRegister.fromJson(Map<String, dynamic> json) => DeviceRegister(
        status: json["status"],
        message: json["message"],
        responseCode: json["responseCode"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "responseCode": responseCode,
        "data": data.toJson(),
      };
}

class Data {
  String visitorToken;

  Data({
    required this.visitorToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        visitorToken: json["visitorToken"],
      );

  Map<String, dynamic> toJson() => {
        "visitorToken": visitorToken,
      };
}
