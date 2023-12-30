import 'dart:convert';

GetProfileResponse getProfileResponseApiFromJson(String str) => GetProfileResponse.fromJson(json.decode(str));
String getProfileResponseApiToJson(GetProfileResponse data) => json.encode(data.toJson());

class GetProfileResponse {
  GetProfileResponse({
    required this.roleId,
    required this.role,
     this.provider,
    required this.participant,
    required this.responseStatus,
    required this.responseMessage,
  });
  late final int roleId;
  late final String role;
  late final Null provider;
  late final Participant participant;
  late final int responseStatus;
  late final String responseMessage;
  
  GetProfileResponse.fromJson(Map<String, dynamic> json){
    roleId = json['roleId'];
    role = json['role'];
    provider = null;
    participant = Participant.fromJson(json['participant']);
    responseStatus = json['responseStatus'];
    responseMessage = json['responseMessage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['roleId'] = roleId;
    _data['role'] = role;
    _data['provider'] = provider;
    _data['participant'] = participant.toJson();
    _data['responseStatus'] = responseStatus;
    _data['responseMessage'] = responseMessage;
    return _data;
  }
}

class Participant {
  Participant({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.ndis,
    required this.email,
    required this.dateOfBirth,
    required this.countryCode,
    required this.location,
    required this.state,
    required this.areaSuburban,
    required this.postalCode,
    required this.phone,
    required this.address,
    required this.aboutUser,
    required this.profilePic,
    required this.profileProgress,
    required this.roleId,
    this.providers,
    required this.roleName,
    required this.lastLoggedin,
    required this.interests,
    required this.ndisStartDate,
    required this.ndisEndDate,
    required this.ndisAgreement,
    required this.ndisTc,
    required this.ServiceAgreement,
  });
  late final int? id;
  late final String? firstName;
  late final String? lastName;
  late final String? gender;
  late final String? ndis;
  late final String? email;
  late final String? dateOfBirth;
  late final String? countryCode;
  late final String? location;
  late final String? state;
  late final String? areaSuburban;
  late final String? postalCode;
  late final String? phone;
  late final String? address;
  late final String? aboutUser;
  late final String? profilePic;
  late final int? profileProgress;
  late final int? roleId;
  late final List<Providers>? providers;
  late final String? roleName;
  late final String? lastLoggedin;
  late final List<Interests>? interests;
  late final String? ndisStartDate;
  late final String? ndisEndDate;
  late final int? ndisAgreement;
  late final int? ndisTc;
  late final int? ServiceAgreement;
  
  Participant.fromJson(Map<String, dynamic> json){
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    ndis = json['ndis'];
    email = json['email'];
    dateOfBirth = json['dateOfBirth'];
    countryCode = json['countryCode'];
    location = json['location'];
    state = json['state'];
    areaSuburban = json['areaSuburban'];
    postalCode = json['postalCode'];
    phone = json['phone'];
    address = json['address'];
    aboutUser = json['aboutUser'];
    profilePic = json['profilePic'];
    profileProgress = json['profileProgress'];
    roleId = json['roleId'];
    providers = json['providers'] != null ? List?.from(json?['providers']).map((e)=>Providers?.fromJson(e)).toList() : null;
    roleName = json['roleName'];
    lastLoggedin = json['lastLoggedin'];
    interests = List.from(json['interests']).map((e)=>Interests.fromJson(e)).toList();
    ndisStartDate = json['ndisStartDate'];
    ndisEndDate = json['ndisEndDate'];
    ndisAgreement = json['ndisAgreement'];
    ndisTc = json['ndisTc'];
    ServiceAgreement = json['ServiceAgreement'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['gender'] = gender;
    _data['ndis'] = ndis;
    _data['email'] = email;
    _data['dateOfBirth'] = dateOfBirth;
    _data['countryCode'] = countryCode;
    _data['location'] = location;
    _data['state'] = state;
    _data['areaSuburban'] = areaSuburban;
    _data['postalCode'] = postalCode;
    _data['phone'] = phone;
    _data['address'] = address;
    _data['aboutUser'] = aboutUser;
    _data['profilePic'] = profilePic;
    _data['profileProgress'] = profileProgress;
    _data['roleId'] = roleId;
    _data['providers'] = providers?.map((e)=>e?.toJson()).toList();
    _data['roleName'] = roleName;
    _data['lastLoggedin'] = lastLoggedin;
    _data['interests'] = interests?.map((e)=>e.toJson()).toList();
    _data['ndisStartDate'] = ndisStartDate;
    _data['ndisEndDate'] = ndisEndDate;
    _data['ndisAgreement'] = ndisAgreement;
    _data['ndisTc'] = ndisTc;
    _data['ServiceAgreement'] = ServiceAgreement;
    return _data;
  }
}

class Providers {
  Providers({
    this.providerName,
    this.providerId,
  });
  late final String? providerName;
  late final int? providerId;
  
  Providers.fromJson(Map<String, dynamic> json){
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

class Interests {
  Interests({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;
  
  Interests.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}