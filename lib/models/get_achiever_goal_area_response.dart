import 'dart:convert';
import 'package:mycareteam/models/create_goal.dart';

GetAchieverGoalAreaResponse getAchieverGoalAreaResponseApiFromJson(String str) =>
    GetAchieverGoalAreaResponse.fromJson(json.decode(str));
String getAchieverGoalAreaResponseApiToJson(GetAchieverGoalAreaResponse data) =>
    json.encode(data.toJson());

class GetAchieverGoalAreaResponse {
  GetAchieverGoalAreaResponse({
    required this.role,
     this.influencer,
    required this.achiever,
  });
  late final String role;
  late final Null influencer;
  late final List<Achiever> achiever;
  
  GetAchieverGoalAreaResponse.fromJson(Map<String, dynamic> json){
    role = json['role'];
    influencer = null;
    achiever = List.from(json['achiever']).map((e)=>Achiever.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['role'] = role;
    _data['influencer'] = influencer;
    _data['achiever'] = achiever.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Achiever {
  Achiever({
    required this.type,
    required this.subTypes,
  });
  late final String type;
  late final List<GoalArea> subTypes;
  
  Achiever.fromJson(Map<String, dynamic> json){
    type = json['type'];
    subTypes = List.from(json['subTypes']).map((e)=>GoalArea.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['subTypes'] = subTypes.map((e)=>e.toJson()).toList();
    return _data;
  }
}