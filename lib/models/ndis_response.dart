import 'dart:convert';

NdisResponse geNdisResponseApiFromJson(String str) => NdisResponse.fromJson(json.decode(str));
String getNdisResponseApiToJson(NdisResponse data) => json.encode(data.toJson());

class NdisResponse {
  NdisResponse({
    required this.ndisAgreementStatus,
    required this.ndisTcStatus,
    required this.responseStatus,
    required this.responseMessage,
  });
  late final int ndisAgreementStatus;
  late final int ndisTcStatus;
  late final int responseStatus;
  late final String responseMessage;
  
  NdisResponse.fromJson(Map<String, dynamic> json){
    ndisAgreementStatus = json['ndisAgreementStatus'];
    ndisTcStatus = json['ndisTcStatus'];
    responseStatus = json['responseStatus'];
    responseMessage = json['responseMessage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ndisAgreementStatus'] = ndisAgreementStatus;
    _data['ndisTcStatus'] = ndisTcStatus;
    _data['responseStatus'] = responseStatus;
    _data['responseMessage'] = responseMessage;
    return _data;
  }
}