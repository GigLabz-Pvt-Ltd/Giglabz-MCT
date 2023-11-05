import 'dart:convert';
import 'package:http/http.dart';
import 'package:mycareteam/models/getProvidersResponse.dart';
import 'package:mycareteam/models/get_states.dart';
import 'package:mycareteam/models/get_profile_response.dart';
import 'package:mycareteam/models/get_roles_response.dart';
import 'package:mycareteam/models/ndis_ques_response.dart';
import '../models/register_response.dart';
import '../models/login_response.dart';

var BASE_URL = "http://dev.trackability.net.au:8081";
var BASE_URL_8080 = "http://dev.trackability.net.au:8080";

class ApiService {
  Future<GetRolesResponse> getRoles() async {
    final response = await get(
      Uri.parse("$BASE_URL/api/get/roles"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final activity = getRolesResponseApiFromJson(response.body);
    return activity;
  }

  Future<RegisterResponse> register(
      String firstName,
      String lastName,
      String phoneNo,
      String email,
      String password,
      String confirmPassword,
      int roleId) async {
    final response = await post(Uri.parse("$BASE_URL/api/signup"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "firstName": firstName,
          "lastName": lastName,
          "phoneNo": phoneNo,
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
          "roleId": roleId,
        }));
    final activity = getRegisterResponseApiFromJson(response.body);
    return activity;
  }

  Future<LoginResponse> login(
      String userName, String password, int roleId) async {
    final response = await post(Uri.parse("$BASE_URL/api/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "username": userName,
          "password": password,
          "roleId": roleId,
        }));
    final activity = getLoginResponseApiFromJson(response.body);
    return activity;
  }

  Future<GetProfileResponse> getProfile(String userName, int roleId) async {
    final response = await get(
      Uri.parse("$BASE_URL_8080/api/userprofile/get/$userName/$roleId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final activity = getProfileResponseApiFromJson(response.body);
    return activity;
  }

  Future<GetNdisQuesResponse> getNdisQues(String userName) async {
    final response = await get(
      Uri.parse("$BASE_URL_8080/api/ndis/questions/$userName"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final activity = getNdisQuesResponseApiFromJson(response.body);
    return activity;
  }

  Future<GetProvidersResponse> getProviders() async {
    final response = await get(
      Uri.parse("$BASE_URL_8080/api/ndis/providers"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final activity = getProvidersResponseApiFromJson(response.body);
    return activity;
  }

  Future<GetStatesResponse> getStates(String country) async {
    final response = await get(
      Uri.parse("$BASE_URL_8080/api/country/states/$country"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final activity = getStatesResponseApiFromJson(response.body);
    return activity;
  }
}
