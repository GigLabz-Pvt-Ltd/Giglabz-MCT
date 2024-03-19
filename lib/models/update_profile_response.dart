import 'dart:convert';

UpdateProfileResponse getUpdateProfileResponseApiFromJson(String str) => UpdateProfileResponse.fromJson(json.decode(str));
String getUpdateProfileResponseApiToJson(UpdateProfileResponse data) => json.encode(data.toJson());

class UpdateProfileResponse {
  UpdateProfileResponse({
    required this.responseStatus,
    required this.responseMessage,
    required this.userId,
    required this.roleId,
  });
  late final int responseStatus;
  late final String responseMessage;
  late final int userId;
  late final int roleId;
  
  UpdateProfileResponse.fromJson(Map<String, dynamic> json){
    responseStatus = json['responseStatus'];
    responseMessage = json['responseMessage'];
    userId = json['userId'];
    roleId = json['roleId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['responseStatus'] = responseStatus;
    _data['responseMessage'] = responseMessage;
    _data['userId'] = userId;
    _data['roleId'] = roleId;
    return _data;
  }
}