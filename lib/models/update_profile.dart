import 'dart:convert';

import 'package:mycareteam/models/get_profile_response.dart';

UpdateProfile getUpdateProfileApiFromJson(String str) =>
    UpdateProfile.fromJson(json.decode(str));
String getUpdateProfileApiToJson(UpdateProfile data) =>
    json.encode(data.toJson());

class UpdateProfile {
  UpdateProfile({
    this.participant,
    this.provider,
  });
  late final UpdateParticipant? participant;
  late final UpdateParticipant? provider;

  UpdateProfile.fromJson(Map<String, dynamic> json) {
    participant = UpdateParticipant.fromJson(json['participant']);
    provider = UpdateParticipant.fromJson(json['provider']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['participant'] = participant?.toJson();
    _data['provider'] = provider?.toJson();
    return _data;
  }
}

class UpdateParticipant {
  UpdateParticipant({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.gender,
    required this.dateOfBirth,
    this.ndisNumber,
    required this.aboutUser,
    required this.postalCode,
    required this.areaSuburban,
    required this.address,
    required this.state,
    required this.country,
    this.ndisStartDate,
    this.ndisEndDate,
    required this.providers,
    this.interests,
    this.providerInviteeList,
  });
  late final String firstName;
  late final String lastName;
  late final String phone;
  late final String email;
  late final String gender;
  late final String dateOfBirth;
  late final String? ndisNumber;
  late final String aboutUser;
  late final String postalCode;
  late final String areaSuburban;
  late final String address;
  late final String state;
  late final String country;
  late final String? ndisStartDate;
  late final String? ndisEndDate;
  late final List<int> providers;
  late final List<Interests>? interests;
  late final List<ProviderList>? providerInviteeList;

  UpdateParticipant.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    email = json['email'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    ndisNumber = json['ndisNumber'];
    aboutUser = json['aboutUser'];
    postalCode = json['postalCode'];
    areaSuburban = json['areaSuburban'];
    address = json['address'];
    state = json['state'];
    country = json['country'];
    ndisStartDate = json['ndisStartDate'];
    ndisEndDate = json['ndisEndDate'];
    providers = List.castFrom<dynamic, int>(json['providers']);
    interests =
        List.from(json['interests']).map((e) => Interests.fromJson(e)).toList();
    providerInviteeList = json['providerInviteeList'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['phone'] = phone;
    _data['email'] = email;
    _data['gender'] = gender;
    _data['dateOfBirth'] = dateOfBirth;
    _data['ndisNumber'] = ndisNumber;
    _data['aboutUser'] = aboutUser;
    _data['postalCode'] = postalCode;
    _data['areaSuburban'] = areaSuburban;
    _data['address'] = address;
    _data['state'] = state;
    _data['country'] = country;
    _data['ndisStartDate'] = ndisStartDate;
    _data['ndisEndDate'] = ndisEndDate;
    _data['providers'] = providers;
    _data['interests'] = interests?.map((e) => e.toJson()).toList();
    _data['providerInviteeList'] = providerInviteeList;
    return _data;
  }
}

class ProviderList{
  ProviderList({
    this.careTeamName,
    this.careTeamEmail,
  });

  late final String? careTeamName;
  late final String? careTeamEmail;

  ProviderList.fromJson(Map<String, dynamic> json) {
    careTeamName = json['careTeamName'];
    careTeamEmail = json['careTeamEmail'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['careTeamName'] = careTeamName;
    _data['careTeamEmail'] = careTeamEmail;
    return _data;
  }
}
