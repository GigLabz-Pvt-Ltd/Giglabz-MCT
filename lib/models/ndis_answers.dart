import 'dart:convert';

NdisAnswers geNdisAnswersApiFromJson(String str) => NdisAnswers.fromJson(json.decode(str));
String getNdisAnswersApiToJson(NdisAnswers data) => json.encode(data.toJson());

class NdisAnswers {
  NdisAnswers({
    required this.email,
    required this.answers,
  });
  late final String email;
  late final List<Answers> answers;
  
  NdisAnswers.fromJson(Map<String, dynamic> json){
    email = json['email'];
    answers = List.from(json['answers']).map((e)=>Answers.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['answers'] = answers.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Answers {
  Answers({
    required this.id,
    required this.question,
    required this.answer,
  });
  late final int id;
  late final String question;
  late final int answer;
  
  Answers.fromJson(Map<String, dynamic> json){
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