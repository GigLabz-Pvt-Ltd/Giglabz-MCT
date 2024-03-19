import 'dart:convert';

GetStatesResponse getStatesResponseApiFromJson(String str) => GetStatesResponse.fromJson(json.decode(str));
String getStatesResponseApiToJson(GetStatesResponse data) => json.encode(data.toJson());

class GetStatesResponse {
  GetStatesResponse({
    required this.state,
  });
  late final List<String> state;
  
  GetStatesResponse.fromJson(Map<String, dynamic> json){
    state = List.castFrom<dynamic, String>(json['state']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['state'] = state;
    return _data;
  }
}