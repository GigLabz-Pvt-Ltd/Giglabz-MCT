import 'dart:convert';

DashboardResponse getDashboardResponseApiFromJson(String str) =>
    DashboardResponse.fromJson(json.decode(str));
String getDashboardResponseApiToJson(DashboardResponse data) =>
    json.encode(data.toJson());

class DashboardResponse {
  DashboardResponse({
    required this.dashboardCount,
    required this.goalList,
  });
  late final List<DashboardCount> dashboardCount;
  late final List<GoalList> goalList;

  DashboardResponse.fromJson(Map<String, dynamic> json) {
    dashboardCount = List.from(json['DashboardCount'])
        .map((e) => DashboardCount.fromJson(e))
        .toList();
    goalList =
        List.from(json['GoalList']).map((e) => GoalList.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['DashboardCount'] = dashboardCount.map((e) => e.toJson()).toList();
    _data['GoalList'] = goalList.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DashboardCount {
  DashboardCount({
    required this.TotalGoals,
    required this.DraftCount,
    required this.DraftPercentage,
    required this.Inprogress,
    required this.InprogressPercentage,
    required this.Pending,
    required this.PendingPercentage,
    required this.Completed,
    required this.CompletedPercentage,
  });
  late final int TotalGoals;
  late final int DraftCount;
  late final int DraftPercentage;
  late final int Inprogress;
  late final int InprogressPercentage;
  late final int Pending;
  late final int PendingPercentage;
  late final int Completed;
  late final int CompletedPercentage;

  DashboardCount.fromJson(Map<String, dynamic> json) {
    TotalGoals = json['Total_Goals'];
    DraftCount = json['Draft_count'];
    DraftPercentage = json['Draft_percentage'];
    Inprogress = json['Inprogress'];
    InprogressPercentage = json['Inprogress_percentage'];
    Pending = json['Pending'];
    PendingPercentage = json['Pending_percentage'];
    Completed = json['Completed'];
    CompletedPercentage = json['Completed_percentage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Total_Goals'] = TotalGoals;
    _data['Draft_count'] = DraftCount;
    _data['Draft_percentage'] = DraftPercentage;
    _data['Inprogress'] = Inprogress;
    _data['Inprogress_percentage'] = InprogressPercentage;
    _data['Pending'] = Pending;
    _data['Pending_percentage'] = PendingPercentage;
    _data['Completed'] = Completed;
    _data['Completed_percentage'] = CompletedPercentage;
    return _data;
  }
}

class GoalList {
  GoalList({
    required this.GoalId,
    required this.GoalName,
    required this.GoalPriority,
    this.GoalArea,
    required this.GoalAreaCustom,
    this.StartDate,
    this.TargetDate,
    required this.GoalStatus,
    required this.GoalPercentage,
    this.GoalReviewer,
    this.Rating,
    this.SharedWith,
    this.reviewedBy,
    this.participants,
    this.reviewed_by,
    this.milestone,
  });
  late final int GoalId;
  late final String GoalName;
  late final String GoalPriority;
  late final Null GoalArea;
  late final String GoalAreaCustom;
  late final String? StartDate;
  late final String? TargetDate;
  late final int GoalStatus;
  late final int GoalPercentage;
  late final Null GoalReviewer;
  late final double? Rating;
  late final List<dynamic>? SharedWith;
  late final List<dynamic>? reviewedBy;
  late final List<DashBoardParticipants>? participants;
  late final Null reviewed_by;
  late final List<DashboardMilestone>? milestone;

  GoalList.fromJson(Map<String, dynamic> json) {
    GoalId = json['GoalId'];
    GoalName = json['Goal_Name'];
    GoalPriority = json['Goal_Priority'];
    GoalArea = null;
    GoalAreaCustom = json['Goal_Area_Custom'];
    StartDate = json['Start_Date'];
    TargetDate = json['Target_Date'];
    GoalStatus = json['Goal_Status'];
    GoalPercentage = json['Goal_percentage'];
    GoalReviewer = null;
    Rating = json['Rating'];
    var s = json['Shared_with'];
    if (s != null) {
      SharedWith = List.castFrom<dynamic, dynamic>(json['Shared_with']);
    } else {
      SharedWith = [];
    }
    var r = json['reviewedBy'];
    if (r != null) {
      reviewedBy = List.castFrom<dynamic, dynamic>(json['reviewedBy']);
    } else {
      reviewedBy = [];
    }
    var p = json['participants'];
    if (p != null) {
      participants = List?.from(json['participants'])
          .map((e) => DashBoardParticipants?.fromJson(e))
          .toList();
    } else {
      participants = null;
    }
    reviewed_by = null;
    milestone =
        List.from(json['milestone']).map((e) => DashboardMilestone.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['GoalId'] = GoalId;
    _data['Goal_Name'] = GoalName;
    _data['Goal_Priority'] = GoalPriority;
    _data['Goal_Area'] = GoalArea;
    _data['Goal_Area_Custom'] = GoalAreaCustom;
    _data['Start_Date'] = StartDate;
    _data['Target_Date'] = TargetDate;
    _data['Goal_Status'] = GoalStatus;
    _data['Goal_percentage'] = GoalPercentage;
    _data['Goal_Reviewer'] = GoalReviewer;
    _data['Rating'] = Rating;
    _data['Shared_with'] = SharedWith;
    _data['reviewedBy'] = reviewedBy;
    _data['participants'] = participants?.map((e) => e.toJson()).toList();
    _data['Reviewed_By'] = reviewed_by;
    _data['milestone'] = milestone?.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ReviewedBy {
  ReviewedBy({
    this.email,
    this.firstName,
    this.lastName,
    this.fullName,
    this.profilePic,
  });
  late final Null email;
  late final Null firstName;
  late final Null lastName;
  late final Null fullName;
  late final Null profilePic;

  ReviewedBy.fromJson(Map<String, dynamic> json) {
    email = null;
    firstName = null;
    lastName = null;
    fullName = null;
    profilePic = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['fullName'] = fullName;
    _data['profilePic'] = profilePic;
    return _data;
  }
}

class DashBoardParticipants {
  DashBoardParticipants({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.profilePic,
  });
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String fullName;
  late final String? profilePic;

  DashBoardParticipants.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    fullName = json['fullName'];
    profilePic = json['profilePic'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['fullName'] = fullName;
    _data['profilePic'] = profilePic;
    return _data;
  }
}

class DashboardMilestone {
  DashboardMilestone({
    required this.name,
    required this.riskAnalysis,
    required this.targetDate,
    required this.lastReviewDate,
    required this.progress,
    this.reviewerComment,
    required this.celebrations,
    required this.milestoneStatus,
    required this.workingWellComment,
    required this.enjoyingAndProgressingComment,
    required this.whatHasChanged,
    required this.sno,
  });
  late final String name;
  late final int riskAnalysis;
  late final String targetDate;
  late final String lastReviewDate;
  late final int progress;
  late final String? reviewerComment;
  late final String celebrations;
  late final int milestoneStatus;
  late final String? workingWellComment;
  late final String? enjoyingAndProgressingComment;
  late final String? whatHasChanged;
  late final int sno;

  DashboardMilestone.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    riskAnalysis = json['riskAnalysis'];
    targetDate = json['targetDate'];
    lastReviewDate = json['lastReviewDate'];
    progress = json['progress'];
    reviewerComment = null;
    celebrations = json['celebrations'];
    milestoneStatus = json['milestoneStatus'];
    workingWellComment = json['workingWellComment'];
    enjoyingAndProgressingComment = json['enjoyingAndProgressingComment'];
    whatHasChanged = json['whatHasChanged'];
    sno = json['sno'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['riskAnalysis'] = riskAnalysis;
    _data['targetDate'] = targetDate;
    _data['lastReviewDate'] = lastReviewDate;
    _data['progress'] = progress;
    _data['reviewerComment'] = reviewerComment;
    _data['celebrations'] = celebrations;
    _data['milestoneStatus'] = milestoneStatus;
    _data['workingWellComment'] = workingWellComment;
    _data['enjoyingAndProgressingComment'] = enjoyingAndProgressingComment;
    _data['whatHasChanged'] = whatHasChanged;
    _data['sno'] = sno;
    return _data;
  }
}
