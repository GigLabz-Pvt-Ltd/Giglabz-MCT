import 'dart:convert';

GetGoalSummary getGoalSummaryApiFromJson(String str) =>
    GetGoalSummary.fromJson(json.decode(str));
String getGoalSummaryApiToJson(GetGoalSummary data) => json.encode(data.toJson());

class GetGoalSummary {
  GetGoalSummary({
    this.id,
    this.title,
    this.priority,
    this.area,
    this.areaCustom,
    this.goalFor,
    this.forSomeoneElse,
    this.recurring,
    this.startDate,
    this.targetDate,
    this.description,
    this.goalStatus,
    this.goalProgress,
    this.goalType
  });
  late final int? id;
  late final String? title;
  late final String? priority;
  late final Area? area;
  late final String? areaCustom;
  late final String? goalFor;
  late final List<SomeoneElse>? forSomeoneElse;
  late final String? recurring;
  late final String? startDate;
  late final String? targetDate;
  late final String? description;
  late final int? goalStatus;
  late final int? goalProgress;
  late final String? goalType;

  GetGoalSummary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    priority = json['priority'];
    area = json['area']!=null ? Area.fromJson(json['area']) : null;
    areaCustom = json['area_custom'];
    goalFor = json['goal_for'];
    forSomeoneElse = List.from(json['forSomeoneElse'])
        .map((e) => SomeoneElse.fromJson(e))
        .toList();
    recurring = json['recurring'];
    startDate = json['start_date'];
    targetDate = json['target_date'];
    description = json['description'];
    goalStatus = json['goal_status'];
    goalProgress = json['goalProgress'];
    goalType = json['goalType'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['priority'] = priority;
    _data['area'] = area?.toJson();
    _data['area_custom'] = areaCustom;
    _data['goal_for'] = goalFor;
    _data['forSomeoneElse'] = forSomeoneElse?.map((e) => e.toJson()).toList();
    _data['recurring'] = recurring;
    _data['start_date'] = startDate;
    _data['target_date'] = targetDate;
    _data['description'] = description;
    _data['goal_status'] = goalStatus;
    _data['goalProgress'] = goalProgress;
    _data['goalType'] = goalType;
    return _data;
  }
}

class Area {
  Area({
    this.name,
    this.id,
    this.type,
    this.subType,
    this.role
  });
  late final String? name;
  late final int? id;
  late final String? type;
  late final String? subType;
  late final String? role;

  Area.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    type = json['type'];
    subType = json['sub_type'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['id'] = id;
    _data['type'] = type;
    _data['sub_type'] = subType;
    _data['role'] = role;
    return _data;
  }
}

class SomeoneElse {
  SomeoneElse({
    this.name,
    this.email,
  });
  late final String? name;
  late final String? email;

  SomeoneElse.fromJson(Map<String, dynamic> json) {
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

// class Group {
//   Group({
//     this.groupName,
//     this.groupMembers
//   });
//   late final String groupName;
//   late final List<ForSomeoneElse> groupMembers;
//
//   ForGroup.fromJson(Map<String, dynamic> json) {
//     groupName = json['groupName'];
//     groupMembers = json['groupMembers'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['groupName'] = groupName;
//     _data['groupMembers'] = groupMembers;
//     return _data;
//   }
// }