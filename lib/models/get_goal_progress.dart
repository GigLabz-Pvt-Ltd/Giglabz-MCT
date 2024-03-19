import 'dart:convert';

GetGoalProgress getGoalProgressApiFromJson(String str) =>
    GetGoalProgress.fromJson(json.decode(str));
String getGoalProgressApiToJson(GetGoalProgress data) => json.encode(data.toJson());

class GetGoalProgress {
  GetGoalProgress(
      {this.overallProgress,
        this.progress,
        this.overallRating,
        this.currentReviewCycleRating,
        this.responseStatus,
        this.responseMessage});

  late final int? overallProgress;
  late final int? progress;
  late final double? overallRating;
  late final List<CurrentReviewCycleRating>? currentReviewCycleRating;
  late final int? responseStatus;
  late final String? responseMessage;

  GetGoalProgress.fromJson(Map<String, dynamic> json) {
    overallProgress = json['overallProgress'];
    progress = json['progress'];
    overallRating = json['overallRating'];
    currentReviewCycleRating = List.from(json['currentReviewCycleRating'])
        .map((e) => CurrentReviewCycleRating.fromJson(e))
        .toList();
    responseStatus = json['responseStatus'];
    responseMessage = json['responseMessage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['overallProgress'] = this.overallProgress;
    _data['progress'] = this.progress;
    _data['overallRating'] = this.overallRating;
    _data['currentReviewCycleRating'] = currentReviewCycleRating?.map((e) => e.toJson()).toList();
    _data['responseStatus'] = this.responseStatus;
    _data['responseMessage'] = this.responseMessage;
    return _data;
  }
}

class CurrentReviewCycleRating {
  CurrentReviewCycleRating(
      {this.id,
        this.parametersToReview,
        this.proofOfProgress,
        this.proofOfProgressUrl,
        this.rating,
        this.current});

  late final int? id;
  late final String? parametersToReview;
  late final dynamic proofOfProgress;
  late final String? proofOfProgressUrl;
  late final double? rating;
  late final bool? current;

  CurrentReviewCycleRating.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parametersToReview = json['parametersToReview'];
    proofOfProgress = json['proofOfProgress'];
    proofOfProgressUrl = json['proofOfProgressUrl'];
    rating = json['rating'];
    current = json['current'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = this.id;
    _data['parametersToReview'] = this.parametersToReview;
    _data['proofOfProgress'] = this.proofOfProgress;
    _data['proofOfProgressUrl'] = this.proofOfProgressUrl;
    _data['rating'] = this.rating;
    _data['current'] = this.current;
    return _data;
  }
}