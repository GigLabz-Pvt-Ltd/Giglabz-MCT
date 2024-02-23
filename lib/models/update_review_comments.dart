import 'dart:convert';

UpdateReviewComments updateReviewCommentsApiFromJson(String str) =>
    UpdateReviewComments.fromJson(json.decode(str));
String updateReviewCommentsApiToJson(UpdateReviewComments data) => json.encode(data.toJson());

class UpdateReviewComments{
  UpdateReviewComments({
    required this.reviewComment,
    required this.roleId,
    required this.email,
    required this.goalId
  });
  late final ReviewComment? reviewComment;
  late final int? roleId;
  late final String? email;
  late final int? goalId;

  UpdateReviewComments.fromJson(Map<String, dynamic> json) {
    var reviewCommentsJson = json['reviewComments'];
    if (reviewCommentsJson != null) {
      if (reviewCommentsJson is Map<String, dynamic>) {
        reviewComment = ReviewComment.fromJson(reviewCommentsJson);
      } else if (reviewCommentsJson is List<dynamic> &&
          reviewCommentsJson.isNotEmpty) {
        reviewComment = ReviewComment.fromJson(reviewCommentsJson[0]);
      }
    }
    roleId = json['roleId'];
    email = json['email'];
    goalId = json['goalId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['reviewComments'] = reviewComment?.toJson();
    _data['roleId'] = roleId;
    _data['email'] = email;
    _data['goalId'] = goalId;
    return _data;
  }
}

class ReviewComment{
  ReviewComment({
    required this.comment
  });

  String? comment;

  ReviewComment.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['comment'] = comment;
    return _data;
  }
}