import 'dart:convert';

RegisterResponse getRegisterResponseApiFromJson(String str) => RegisterResponse.fromJson(json.decode(str));
String getRegisterResponseApiToJson(RegisterResponse data) => json.encode(data.toJson());

class RegisterResponse {
  RegisterResponse({
    required this.responseStatus,
    required this.responseMessage,
    required this.responseHeaders,
  });
  late final int? responseStatus;
  late final String? responseMessage;
  late final String? responseHeaders;
  
  RegisterResponse.fromJson(Map<String, dynamic> json){
    responseStatus = json['responseStatus'];
    responseMessage = json['responseMessage'];
    responseHeaders = json['responseHeaders'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['responseStatus'] = responseStatus;
    _data['responseMessage'] = responseMessage;
    _data['responseHeaders'] = responseHeaders;
    return _data;
  }
}