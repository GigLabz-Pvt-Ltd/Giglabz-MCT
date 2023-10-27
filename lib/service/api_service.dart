import 'dart:convert';
import 'package:http/http.dart';
import '../models/register_response.dart';
import '../models/login_response.dart';

var BASE_URL = "http://dev.trackability.net.au:8081";

class ApiService {
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
