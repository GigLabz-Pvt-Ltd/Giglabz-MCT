import 'dart:convert';

ShareGoal shareGoalApiFromJson(String str) => ShareGoal.fromJson(json.decode(str));
String shareGoalApiToJson(ShareGoal data) => json.encode(data.toJson());

class ShareGoal {
  ShareGoal({
    required this.shareGoalTo,
    required this.goalId,
    required this.family,
    required this.reviewer,
  });
  late final int shareGoalTo;
  late final int goalId;
  late final Family family;
  late final Reviewer reviewer;
  
  ShareGoal.fromJson(Map<String, dynamic> json){
    shareGoalTo = json['shareGoalTo'];
    goalId = json['goalId'];
    family = Family.fromJson(json['family']);
    reviewer = Reviewer.fromJson(json['reviewer']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['shareGoalTo'] = shareGoalTo;
    _data['goalId'] = goalId;
    _data['family'] = family.toJson();
    _data['reviewer'] = reviewer.toJson();
    return _data;
  }
}

class Family {
  Family({
    required this.familyColleagueList,
  });
  late final List<FamilyColleagueList> familyColleagueList;
  
  Family.fromJson(Map<String, dynamic> json){
    familyColleagueList = List.from(json['familyColleagueList']).map((e)=>FamilyColleagueList.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['familyColleagueList'] = familyColleagueList.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class FamilyColleagueList {
  FamilyColleagueList({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNo,
    required this.role,
    required this.shareReason,
    required this.notificatioin,
    required this.editable,
    required this.view,
    required this.frequency,
  });
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String phoneNo;
  late final String role;
  late final String shareReason;
  late final int notificatioin;
  late final bool editable;
  late final int view;
  late final String frequency;
  
  FamilyColleagueList.fromJson(Map<String, dynamic> json){
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    role = json['role'];
    shareReason = json['shareReason'];
    notificatioin = json['notificatioin'];
    editable = json['editable'];
    view = json['view'];
    frequency = json['frequency'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['email'] = email;
    _data['phoneNo'] = phoneNo;
    _data['role'] = role;
    _data['shareReason'] = shareReason;
    _data['notificatioin'] = notificatioin;
    _data['editable'] = editable;
    _data['view'] = view;
    _data['frequency'] = frequency;
    return _data;
  }
}

class Reviewer {
  Reviewer({
    required this.parametersToReview,
    required this.reviewerList,
  });
  late final List<ParametersToReview> parametersToReview;
  late final List<ReviewerList> reviewerList;
  
  Reviewer.fromJson(Map<String, dynamic> json){
    parametersToReview = List.from(json['parametersToReview']).map((e)=>ParametersToReview.fromJson(e)).toList();
    reviewerList = List.from(json['reviewerList']).map((e)=>ReviewerList.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['parametersToReview'] = parametersToReview.map((e)=>e.toJson()).toList();
    _data['reviewerList'] = reviewerList.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ParametersToReview {
  ParametersToReview({
    required this.id,
    required this.parameter,
    required this.frequency,
    required this.proofOfProgress,
  });
  late final int id;
  late final String parameter;
  late final String frequency;
  late final String proofOfProgress;
  
  ParametersToReview.fromJson(Map<String, dynamic> json){
    id = json['id'];
    parameter = json['parameter'];
    frequency = json['frequency'];
    proofOfProgress = json['proofOfProgress'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['parameter'] = parameter;
    _data['frequency'] = frequency;
    _data['proofOfProgress'] = proofOfProgress;
    return _data;
  }
}

class ReviewerList {
  ReviewerList({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNo,
    required this.role,
    required this.shareReason,
    required this.editable,
  });
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String phoneNo;
  late final String role;
  late final String shareReason;
  late final bool editable;
  
  ReviewerList.fromJson(Map<String, dynamic> json){
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    role = json['role'];
    shareReason = json['shareReason'];
    editable = json['editable'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['email'] = email;
    _data['phoneNo'] = phoneNo;
    _data['role'] = role;
    _data['shareReason'] = shareReason;
    _data['editable'] = editable;
    return _data;
  }
}