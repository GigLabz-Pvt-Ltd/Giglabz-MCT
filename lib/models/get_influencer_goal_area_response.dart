import 'dart:convert';

GetInfluencerGoalAreaResponse getInfluencerGoalAreaResponseApiFromJson(String str) =>
    GetInfluencerGoalAreaResponse.fromJson(json.decode(str));
String getInfluencerGoalAreaResponseApiToJson(GetInfluencerGoalAreaResponse data) =>
    json.encode(data.toJson());

class GetInfluencerGoalAreaResponse {
  GetInfluencerGoalAreaResponse({
    required this.role,
    required this.influencer,
     this.achiever,
  });
  late final String role;
  late final List<Influencer> influencer;
  late final Null achiever;
  
  GetInfluencerGoalAreaResponse.fromJson(Map<String, dynamic> json){
    role = json['role'];
    influencer = List.from(json['influencer']).map((e)=>Influencer.fromJson(e)).toList();
    achiever = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['role'] = role;
    _data['influencer'] = influencer.map((e)=>e.toJson()).toList();
    _data['achiever'] = achiever;
    return _data;
  }
}

class Influencer {
  Influencer({
    required this.type,
    required this.subTypes,
  });
  late final String type;
  late final List<ISubTypes> subTypes;
  
  Influencer.fromJson(Map<String, dynamic> json){
    type = json['type'];
    subTypes = List.from(json['subTypes']).map((e)=>ISubTypes.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['subTypes'] = subTypes.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ISubTypes {
  ISubTypes({
    required this.subType,
    required this.goals,
  });
  late final String subType;
  late final List<IGoals> goals;
  
  ISubTypes.fromJson(Map<String, dynamic> json){
    subType = json['subType'];
    goals = List.from(json['goals']).map((e)=>IGoals.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['subType'] = subType;
    _data['goals'] = goals.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class IGoals {
  IGoals({
    required this.name,
    required this.id,
  });
  late final String name;
  late final int id;
  
  IGoals.fromJson(Map<String, dynamic> json){
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['id'] = id;
    return _data;
  }
}