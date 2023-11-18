import 'dart:convert';
import 'package:http/http.dart';
import 'package:mycareteam/models/create_goal.dart';
import 'package:mycareteam/models/create_goal_response.dart';
import 'package:mycareteam/models/getProvidersResponse.dart';
import 'package:mycareteam/models/get_areas.dart';
import 'package:mycareteam/models/get_dashboard_response.dart';
import 'package:mycareteam/models/get_states.dart';
import 'package:mycareteam/models/get_profile_response.dart';
import 'package:mycareteam/models/get_roles_response.dart';
import 'package:mycareteam/models/ndis_answers.dart';
import 'package:mycareteam/models/ndis_ques_response.dart';
import 'package:mycareteam/models/ndis_response.dart';
import 'package:mycareteam/models/update_profile.dart';
import 'package:mycareteam/models/update_profile_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/register_response.dart';
import '../models/login_response.dart';

var BASE_URL = "http://dev.trackability.net.au:8081";
var BASE_URL_8080 = "http://dev.trackability.net.au:8080";
var BASE_URL_8082 = "http://dev.trackability.net.au:8082";

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

  Future<GetAreasResponse> getAreas(String state) async {
    final response = await get(
      Uri.parse("$BASE_URL_8080/api/country/areas/$state"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final activity = getAreasResponseApiFromJson(response.body);
    return activity;
  }

  Future<NdisResponse> postNdisAnswers(NdisAnswers answers) async {
    final response =
        await post(Uri.parse("$BASE_URL_8080/api/ndis/save/answers"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: getNdisAnswersApiToJson(answers));
    final activity = geNdisResponseApiFromJson(response.body);
    return activity;
  }

  Future<NdisResponse> postNdisTc(String email, int tc) async {
    final response = await post(Uri.parse("$BASE_URL_8080/api/ndis/save/tc"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "email": email,
          "tc": tc,
        }));
    final activity = geNdisResponseApiFromJson(response.body);
    return activity;
  }

  Future<UpdateProfileResponse> updateProfile(UpdateProfile profile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userPref = prefs.getString('user')!;
    var userMap = jsonDecode(userPref) as Map<String, dynamic>;

    final response = await post(
        Uri.parse(
            "$BASE_URL_8080/api/userprofile/update/user/${userMap["user_name"]}/${userMap["role_id"]}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: getUpdateProfileApiToJson(profile));
    final activity = getUpdateProfileResponseApiFromJson(response.body);
    return activity;
  }

  Future<DashboardResponse> getDashBoard(String email) async {
    final response = await get(
      // Uri.parse("$BASE_URL_8082/goals/dashboard/gitowe3414@ipniel.com"),
      Uri.parse("$BASE_URL_8082/goals/dashboard/$email"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final activity = getDashboardResponseApiFromJson(response.body);
    return activity;
  }

  Future<CreateGoalResponse> createGoal(CreateGoal goal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userPref = prefs.getString('user')!;
    var userMap = jsonDecode(userPref) as Map<String, dynamic>;

    final response =
        await post(Uri.parse("$BASE_URL_8082/goals/summary/save/2686"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: createGoalApiToJson(goal));
    final activity = createGoalResponseApiFromJson(response.body);
    return activity;
  }
}
