import 'dart:convert';

UpdateMilestone updateMilestoneApiFromJson(String str) =>
    UpdateMilestone.fromJson(json.decode(str));
String updateMilestoneApiToJson(UpdateMilestone data) =>
    json.encode(data.toJson());

class UpdateMilestone{
  UpdateMilestone({
    required this.riskAnalysis,
    required this.milestoneStatus,
    required this.workingWellComment,
    required this.enjoyingAndProgressingComment,
    required this.whatHasChanged,
    required this.email,
    required this.roleId
  });
  int? riskAnalysis;
  int? milestoneStatus;
  String? workingWellComment;
  String? enjoyingAndProgressingComment;
  String? whatHasChanged;
  String? email;
  int? roleId;

  UpdateMilestone.fromJson(Map<String, dynamic> json) {
    riskAnalysis = json['riskAnalysis'];
    milestoneStatus = json['milestoneStatus'];
    workingWellComment = json['workingWellComment'];
    enjoyingAndProgressingComment = json['enjoyingAndProgressingComment'];
    whatHasChanged = json['whatHasChanged'];
    email = json['email'];
    roleId = json['roleId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['riskAnalysis'] = riskAnalysis;
    _data['milestoneStatus'] = milestoneStatus;
    _data['workingWellComment'] = workingWellComment;
    _data['enjoyingAndProgressingComment'] = enjoyingAndProgressingComment;
    _data['email'] = email;
    _data['roleId'] = roleId;
    return _data;
  }
}