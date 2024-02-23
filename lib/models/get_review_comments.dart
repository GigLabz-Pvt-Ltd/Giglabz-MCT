import 'dart:convert';

GetReviewComments getReviewCommentsApiFromJson(String str) =>
    GetReviewComments.fromJson(json.decode(str));
String getReviewCommentsApiToJson(GetReviewComments data) =>
    json.encode(data..toJson());

class GetReviewComments{
  GetReviewComments({
    required this.reviewComments,
    required this.responseStatus,
    required this.responseMessage
  });
  late final List<ReviewChat>? reviewComments;
  late final int? responseStatus;
  late final String? responseMessage;

  GetReviewComments.fromJson(Map<String, dynamic> json) {
    reviewComments = json['reviewComments']!=null ? List.from(json['reviewComments']).map((e) => ReviewChat.fromJson(e)).toList() : null;
    responseStatus = json['responseStatus'];
    responseMessage = json['responseMessage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['reviewComments'] = reviewComments?.map((e) => e.toJson()).toList();
    _data['responseStatus'] = responseStatus;
    _data['responseMessage'] = responseMessage;
    return _data;
  }
}

class ReviewChat{
  ReviewChat({
    required this.id,
    required this.comment,
    required this.updatedAt,
    required this.role,
    required this.name,
    required this.profilePic
  });
  late final int id;
  late final String comment;
  late final String updatedAt;
  late final String role;
  late final String name;
  late final String profilePic;

  ReviewChat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    updatedAt = json['updatedAt'];
    role = json['role'];
    name = json['name'];
    profilePic = json['profilePic'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['comment'] = comment;
    _data['updatedAt'] = updatedAt;
    _data['role'] = role;
    _data['name'] = name;
    _data['profilePic'] = profilePic;
    return _data;
  }
}