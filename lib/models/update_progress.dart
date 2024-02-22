import "dart:convert";

UpdateGoalProgress updateGoalProgressApiFromJson(String str) =>
    UpdateGoalProgress.fromJson(json.decode(str));
String updateGoalProgressApiToJson(UpdateGoalProgress data) => json.encode(data.toJson());

class UpdateGoalProgress {
  UpdateGoalProgress(
      {
        required this.overallProgress,
        required this.progress,
        required this.overallRating,
        required this.currentReviewCycleRating,
        required this.responseStatus,
        required this.responseMessage,
        required this.roleId,
        required this.goalId,
        required this.email
      });

  late final int overallProgress;
  late final int progress;
  late final double overallRating;
  late final List<ReviewRating> currentReviewCycleRating;
  late final int responseStatus;
  late final String responseMessage;
  late final int? roleId;
  late final int? goalId;
  late final String? email;

  UpdateGoalProgress.fromJson(Map<String, dynamic> json) {
    overallProgress = json['overallProgress'];
    progress = json['progress'];
    overallRating = json['overallRating'];
    currentReviewCycleRating = List.from(json['currentReviewCycleRating'])
        .map((e) => ReviewRating.fromJson(e))
        .toList();
    responseStatus = json['responseStatus'];
    responseMessage = json['responseMessage'];
    roleId = json['roleId'];
    goalId = json['goalId'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['overallProgress'] = overallProgress;
    data['progress'] = progress;
    data['overallRating'] = overallRating;
    data['currentReviewCycleRating'] = currentReviewCycleRating.map((e)=>e.toJson()).toList();
    data['responseStatus'] = responseStatus;
    data['responseMessage'] = responseMessage;
    data['roleId'] = roleId;
    data['goalId'] = goalId;
    data['email'] = email;
    return data;
  }
}

class ReviewRating {
  int? id;
  String? parametersToReview;
  dynamic proofOfProgress;
  String? proofOfProgressUrl;
  double? rating;
  bool? current;

  ReviewRating(
      {required this.id,
        required this.parametersToReview,
        this.proofOfProgress,
        required this.proofOfProgressUrl,
        required this.rating,
        required this.current});

  ReviewRating.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parametersToReview = json['parametersToReview'];
    proofOfProgress = json['proofOfProgress'];
    proofOfProgressUrl = json['proofOfProgressUrl'];
    rating = json['rating'];
    current = json['current'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parametersToReview'] = this.parametersToReview;
    data['proofOfProgress'] = this.proofOfProgress;
    data['proofOfProgressUrl'] = this.proofOfProgressUrl;
    data['rating'] = this.rating;
    data['current'] = this.current;
    return data;
  }
}