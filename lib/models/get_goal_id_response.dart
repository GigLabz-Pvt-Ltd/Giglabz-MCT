import 'dart:convert';

GetGoalIdResponse getGoalIdResponseApiFromJson(String str) =>
    GetGoalIdResponse.fromJson(json.decode(str));
String getGoalIdResponseApiToJson(GetGoalIdResponse data) =>
    json.encode(data.toJson());

class GetGoalIdResponse {
  GetGoalIdResponse({
    required this.responseStatus,
    required this.responseMessage,
    required this.goalId,
    required this.goalPercent,
  });
  late final int responseStatus;
  late final String responseMessage;
  late final int goalId;
  late final int goalPercent;

  GetGoalIdResponse.fromJson(Map<String, dynamic> json) {
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
