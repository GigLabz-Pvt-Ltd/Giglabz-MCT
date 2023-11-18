import 'dart:convert';

CreateGoalResponse createGoalResponseApiFromJson(String str) => CreateGoalResponse.fromJson(json.decode(str));
String createGoalResponseApiToJson(CreateGoalResponse data) => json.encode(data.toJson());

class CreateGoalResponse {
  CreateGoalResponse({
    required this.responseStatus,
    required this.responseMessage,
    required this.goalId,
    required this.goalPercent,
  });
  late final int responseStatus;
  late final String responseMessage;
  late final int goalId;
  late final int goalPercent;
  
  CreateGoalResponse.fromJson(Map<String, dynamic> json){
    responseStatus = json['responseStatus'];
    responseMessage = json['responseMessage'];
    goalId = json['goalId'];
    goalPercent = json['goalPercent'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['responseStatus'] = responseStatus;
    _data['responseMessage'] = responseMessage;
    _data['goalId'] = goalId;
    _data['goalPercent'] = goalPercent;
    return _data;
  }
}