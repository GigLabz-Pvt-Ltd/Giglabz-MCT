import 'dart:convert';

ForgotPasswordResponse forgotPasswordResponseApiFromJson(String str) => ForgotPasswordResponse.fromJson(json.decode(str));
String forgotPasswordResponseApiToJson(ForgotPasswordResponse data) => json.encode(data.toJson());
class ForgotPasswordResponse {
  ForgotPasswordResponse({
    required this.responseStatus,
    required this.responseMessage,
  });
  late final int responseStatus;
  late final String responseMessage;
  
  ForgotPasswordResponse.fromJson(Map<String, dynamic> json){
    responseStatus = json['responseStatus'];
    responseMessage = json['responseMessage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['responseStatus'] = responseStatus;
    _data['responseMessage'] = responseMessage;
    return _data;
  }
}