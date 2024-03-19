import 'dart:convert';

GetMilestone getMilestoneApiFromJson(String str) =>
    GetMilestone.fromJson(json.decode(str));
String GetMilestoneApiToJson(GetMilestone data) =>
    json.encode(data.toJson());

class GetMilestone {
  GetMilestone({
    this.expectedOutcome,
    this.breakdown,
    this.milestone,
  });
  late final String? expectedOutcome;
  late final int? breakdown;
  late final List<AddMilestone>? milestone;

  GetMilestone.fromJson(Map<String, dynamic> json) {
    expectedOutcome = json['expectedOutcome'];
    breakdown = json['breakdown'];
    milestone = json['milestone']!=null? List.from(json['milestone']).map((e) => AddMilestone.fromJson(e)).toList(): null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['expectedOutcome'] = expectedOutcome;
    _data['breakdown'] = breakdown;
    _data['milestone'] = milestone?.map((e) => e.toJson()).toList();
    return _data;
  }
}

class AddMilestone {
  AddMilestone({
    this.name,
    this.description,
    this.startDate,
    this.targetDate,
    this.celebrations,
    this.progress,
  });
  late final String? name;
  late final String? description;
  late final String? startDate;
  late final String? targetDate;
  late final String? celebrations;
  late final int? progress;

  AddMilestone.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    startDate = json['startDate'];
    targetDate = json['targetDate'];
    celebrations = json['celebrations'];
    progress = json['progress'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['description'] = description;
    _data['startDate'] = startDate;
    _data['targetDate'] = targetDate;
    _data['celebrations'] = celebrations;
    _data['progress'] = progress;
    return _data;
  }
}
