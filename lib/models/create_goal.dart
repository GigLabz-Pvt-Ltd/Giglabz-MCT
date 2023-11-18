import 'dart:convert';

CreateGoal createGoalApiFromJson(String str) => CreateGoal.fromJson(json.decode(str));
String createGoalApiToJson(CreateGoal data) => json.encode(data.toJson());

class CreateGoal {
  CreateGoal({
    required this.title,
    required this.priority,
    required this.area,
    required this.areaCustom,
    required this.goalFor,
    required this.forSomeoneElse,
    required this.recurring,
    required this.startDate,
    required this.targetDate,
    required this.description,
  });
  late final String title;
  late final String priority;
  late final GoalArea area;
  late final String areaCustom;
  late final String goalFor;
  late final List<ForSomeoneElse> forSomeoneElse;
  late final String recurring;
  late final String startDate;
  late final String targetDate;
  late final String description;
  
  CreateGoal.fromJson(Map<String, dynamic> json){
    title = json['title'];
    priority = json['priority'];
    area = GoalArea.fromJson(json['area']);
    areaCustom = json['area_custom'];
    goalFor = json['goal_for'];
    forSomeoneElse = List.from(json['forSomeoneElse']).map((e)=>ForSomeoneElse.fromJson(e)).toList();
    recurring = json['recurring'];
    startDate = json['start_date'];
    targetDate = json['target_date'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['priority'] = priority;
    _data['area'] = area.toJson();
    _data['area_custom'] = areaCustom;
    _data['goal_for'] = goalFor;
    _data['forSomeoneElse'] = forSomeoneElse.map((e)=>e.toJson()).toList();
    _data['recurring'] = recurring;
    _data['start_date'] = startDate;
    _data['target_date'] = targetDate;
    _data['description'] = description;
    return _data;
  }
}

class GoalArea {
  GoalArea({
    required this.name,
    required this.id,
  });
  late final String name;
  late final int id;
  
  GoalArea.fromJson(Map<String, dynamic> json){
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

class ForSomeoneElse {
  ForSomeoneElse({
    required this.name,
    required this.email,
  });
  late final String name;
  late final String email;
  
  ForSomeoneElse.fromJson(Map<String, dynamic> json){
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['email'] = email;
    return _data;
  }
}