import 'dart:convert';

GetNdisQuesResponse getNdisQuesResponseApiFromJson(String str) => GetNdisQuesResponse.fromJson(json.decode(str));
String getNdisQuesResponseApiToJson(GetNdisQuesResponse data) => json.encode(data.toJson());


class GetNdisQuesResponse {
  GetNdisQuesResponse({
    required this.questions,
    required this.responseStatus,
    required this.responseMessage,
  });
  late final List<Questions> questions;
  late final int responseStatus;
  late final String responseMessage;
  
  GetNdisQuesResponse.fromJson(Map<String, dynamic> json){
    questions = List.from(json['questions']).map((e)=>Questions.fromJson(e)).toList();
    responseStatus = json['responseStatus'];
    responseMessage = json['responseMessage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['questions'] = questions.map((e)=>e.toJson()).toList();
    _data['responseStatus'] = responseStatus;
    _data['responseMessage'] = responseMessage;
    return _data;
  }
}

class Questions {
  Questions({
    required this.id,
    required this.question,
    required this.answer,
  });
  late final int id;
  late final String question;
  late final int answer;
  
  Questions.fromJson(Map<String, dynamic> json){
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['question'] = question;
    _data['answer'] = answer;
    return _data;
  }
}