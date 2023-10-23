import 'dart:convert';

LoginResponse getLoginResponseApiFromJson(String str) => LoginResponse.fromJson(json.decode(str));
String getLoginResponseApiToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.idToken,
    required this.accessToken,
    required this.message,
    required this.statusCode,
    required this.refreshToken,
    required this.roleId,
  });
  late final String? idToken;
  late final String? accessToken;
  late final String? message;
  late final int? statusCode;
  late final String? refreshToken;
  late final int? roleId;
  
  LoginResponse.fromJson(Map<String, dynamic> json){
    idToken = json['idToken'];
    accessToken = json['accessToken'];
    message = json['message'];
    statusCode = json['statusCode'];
    refreshToken = json['refreshToken'];
    roleId = json['roleId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['idToken'] = idToken;
    _data['accessToken'] = accessToken;
    _data['message'] = message;
    _data['statusCode'] = statusCode;
    _data['refreshToken'] = refreshToken;
    _data['roleId'] = roleId;
    return _data;
  }
}