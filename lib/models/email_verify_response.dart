import 'dart:convert';

EmailVerifyResponse emailVerifyResponseApiFromJson(String str) => EmailVerifyResponse.fromJson(json.decode(str));
String emailVerifyResponseApiToJson(EmailVerifyResponse data) => json.encode(data.toJson());

class EmailVerifyResponse {
  EmailVerifyResponse({
    required this.responseStatus,
    required this.responseMessage,
     this.responseHeaders,
  });
  late final int responseStatus;
  late final String responseMessage;
  late final Null responseHeaders;
  
  EmailVerifyResponse.fromJson(Map<String, dynamic> json){
    responseStatus = json['responseStatus'];
    responseMessage = json['responseMessage'];
    responseHeaders = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['responseStatus'] = responseStatus;
    _data['responseMessage'] = responseMessage;
    _data['responseHeaders'] = responseHeaders;
    return _data;
  }
}