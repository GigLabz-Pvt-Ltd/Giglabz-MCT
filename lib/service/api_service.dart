import 'dart:convert';
import 'package:http/http.dart';
import 'package:mycareteam/models/get_roles_response.dart';
import '../models/register_response.dart';
import '../models/login_response.dart';

var BASE_URL = "http://dev.trackability.net.au:8081";

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
}
