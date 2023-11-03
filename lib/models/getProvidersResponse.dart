import 'dart:convert';

GetProvidersResponse getProvidersResponseApiFromJson(String str) => GetProvidersResponse.fromJson(json.decode(str));
String getProvidersResponseApiToJson(GetProvidersResponse data) => json.encode(data.toJson());

class GetProvidersResponse {
  GetProvidersResponse({
    required this.providerNames,
    required this.responseStatus,
    required this.responseMessage,
  });
  late final List<ProviderNames> providerNames;
  late final int responseStatus;
  late final String responseMessage;
  
  GetProvidersResponse.fromJson(Map<String, dynamic> json){
    providerNames = List.from(json['providerNames']).map((e)=>ProviderNames.fromJson(e)).toList();
    responseStatus = json['responseStatus'];
    responseMessage = json['responseMessage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['providerNames'] = providerNames.map((e)=>e.toJson()).toList();
    _data['responseStatus'] = responseStatus;
    _data['responseMessage'] = responseMessage;
    return _data;
  }
}

class ProviderNames {
  ProviderNames({
    required this.providerName,
    required this.providerId,
  });
  late final String providerName;
  late final int providerId;
  
  ProviderNames.fromJson(Map<String, dynamic> json){
    providerName = json['providerName'];
    providerId = json['providerId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['providerName'] = providerName;
    _data['providerId'] = providerId;
    return _data;
  }
}