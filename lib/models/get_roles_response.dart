import 'dart:convert';

GetRolesResponse getRolesResponseApiFromJson(String str) => GetRolesResponse.fromJson(json.decode(str));
String getRolesResponseApiToJson(GetRolesResponse data) => json.encode(data.toJson());


class GetRolesResponse {
  GetRolesResponse({
    required this.roles,
    required this.responseStatus,
    required this.responseMessage,
  });
  late final List<Roles> roles;
  late final int responseStatus;
  late final String responseMessage;
  
  GetRolesResponse.fromJson(Map<String, dynamic> json){
    roles = List.from(json['roles']).map((e)=>Roles.fromJson(e)).toList();
    responseStatus = json['responseStatus'];
    responseMessage = json['responseMessage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['roles'] = roles.map((e)=>e.toJson()).toList();
    _data['responseStatus'] = responseStatus;
    _data['responseMessage'] = responseMessage;
    return _data;
  }
}

class Roles {
  Roles({
    required this.id,
    required this.name,
    required this.description,
  });
  late final int id;
  late final String name;
  late final String description;
  
  Roles.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['description'] = description;
    return _data;
  }
}