import 'dart:convert';

GetAreasResponse getAreasResponseApiFromJson(String str) => GetAreasResponse.fromJson(json.decode(str));
String getAreasResponseApiToJson(GetAreasResponse data) => json.encode(data.toJson());

class GetAreasResponse {
  GetAreasResponse({
    required this.area,
  });
  late final List<Area> area;
  
  GetAreasResponse.fromJson(Map<String, dynamic> json){
    area = List.from(json['area']).map((e)=>Area.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['area'] = area.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Area {
  Area({
    required this.name,
    required this.postalCode,
  });
  late final String name;
  late final String postalCode;
  
  Area.fromJson(Map<String, dynamic> json){
    name = json['name'];
    postalCode = json['postalCode'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['postalCode'] = postalCode;
    return _data;
  }
}