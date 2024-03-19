import 'dart:convert';

CreateMilestone createMilestoneApiFromJson(String str) =>
    CreateMilestone.fromJson(json.decode(str));
String createMilestoneApiToJson(CreateMilestone data) =>
    json.encode(data.toJson());

class CreateMilestone {
  CreateMilestone({
    required this.expectedOutcome,
    required this.breakdown,
    this.milestone,
    required this.goalId,
  });
  late final String expectedOutcome;
  late final int breakdown;
  late final List<Milestone>? milestone;
  late final int goalId;

  CreateMilestone.fromJson(Map<String, dynamic> json) {
    expectedOutcome = json['expectedOutcome'];
    breakdown = json['breakdown'];
    milestone =
        List.from(json['milestone']).map((e) => Milestone.fromJson(e)).toList();
    goalId = json['goalId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['expectedOutcome'] = expectedOutcome;
    _data['breakdown'] = breakdown;
    _data['milestone'] = milestone?.map((e) => e.toJson()).toList();
    _data['goalId'] = goalId;
    return _data;
  }
}

class Milestone {
  Milestone({
    required this.name,
    required this.description,
    required this.startDate,
    required this.targetDate,
    required this.celebrations,
    required this.progress,
    required this.value,
    required this.action,
  });
  late final String name;
  late final String description;
  late final String startDate;
  late final String targetDate;
  late final String celebrations;
  late final String progress;
  late final bool value;
  late final int action;

  Milestone.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    startDate = json['startDate'];
    targetDate = json['targetDate'];
    celebrations = json['celebrations'];
    progress = json['progress'];
    value = json['value'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['description'] = description;
    _data['startDate'] = startDate;
    _data['targetDate'] = targetDate;
    _data['celebrations'] = celebrations;
    _data['progress'] = progress;
    _data['value'] = value;
    _data['action'] = action;
    return _data;
  }
}
