import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:mycareteam/models/create_goal.dart';
import 'package:mycareteam/models/create_goal_response.dart';
import 'package:mycareteam/models/create_milestone.dart';
import 'package:mycareteam/models/email_verify_response.dart';
import 'package:mycareteam/models/forgot_password_response.dart';
import 'package:mycareteam/models/getProvidersResponse.dart';
import 'package:mycareteam/models/get_areas.dart';
import 'package:mycareteam/models/get_dashboard_response.dart';
import 'package:mycareteam/models/get_achiever_goal_area_response.dart';
import 'package:mycareteam/models/get_goal_id_response.dart';
import 'package:mycareteam/models/get_goal_milestone.dart';
import 'package:mycareteam/models/get_goal_progress.dart';
import 'package:mycareteam/models/get_goal_summary.dart';
import 'package:mycareteam/models/get_influencer_goal_area_response.dart';
import 'package:mycareteam/models/get_review_comments.dart';
import 'package:mycareteam/models/get_states.dart';
import 'package:mycareteam/models/get_profile_response.dart';
import 'package:mycareteam/models/get_roles_response.dart';
import 'package:mycareteam/models/ndis_answers.dart';
import 'package:mycareteam/models/ndis_ques_response.dart';
import 'package:mycareteam/models/ndis_response.dart';
import 'package:mycareteam/models/share_goal.dart';
import 'package:mycareteam/models/update_milestone.dart';
import 'package:mycareteam/models/update_profile.dart';
import 'package:mycareteam/models/update_profile_response.dart';
import 'package:mycareteam/models/update_progress.dart';
import 'package:mycareteam/models/update_review_comments.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/register_response.dart';
import '../models/login_response.dart';
import 'package:path/path.dart';

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
      String userName, String password, int roleId, String deviceType, String deviceToken, String deviceDetails) async {
    final response = await post(Uri.parse("$BASE_URL/api/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "username": userName,
          "password": password,
          "roleId": roleId,
          "deviceType": deviceType,
          "deviceToken": deviceToken,
          "deviceDetails": deviceDetails
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

  Future<UpdateProfileResponse?> updateProfile(UpdateProfile profile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userPref = prefs.getString('user')!;
    var userMap = jsonDecode(userPref) as Map<String, dynamic>;

    print(getUpdateProfileApiToJson(profile));

    final response = await post(
        Uri.parse(
            "$BASE_URL_8080/api/userprofile/update/user/${userMap["user_name"]}/${userMap["role_id"]}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: getUpdateProfileApiToJson(profile));
    print("Update profile code: ${response.statusCode}");
    if(response.statusCode == 200){
      final activity = getUpdateProfileResponseApiFromJson(response.body);
      return activity;
    }
    return null;
  }

  Future<DashboardResponse?> getDashBoard(String email) async {
    final response = await get(
      // Uri.parse("$BASE_URL_8082/goals/dashboard/gitowe3414@ipniel.com"),
      Uri.parse("$BASE_URL_8082/goals/dashboard/$email"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
   if(response.statusCode == 200){
     print("Get Dashboard ${response.body}");
     print("Get Dashboard ${response.statusCode}");
     final activity = getDashboardResponseApiFromJson(response.body);
     return activity;
   }
    return null;
  }

  Future<CreateGoalResponse> createGoal(int goalId, CreateGoal goal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userPref = prefs.getString('user')!;
    var userMap = jsonDecode(userPref) as Map<String, dynamic>;

    final response =
        await post(Uri.parse("$BASE_URL_8082/goals/summary/save/$goalId"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: createGoalApiToJson(goal));
    final activity = createGoalResponseApiFromJson(response.body);
    return activity;
  }

  Future<EmailVerifyResponse> emailVerify(
      String email, String code, String username) async {
    final response = await post(Uri.parse("$BASE_URL/api/signup/emailverify"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "email": email,
          "verifyCode": code,
          "username": username
        }));
    final activity = emailVerifyResponseApiFromJson(response.body);
    return activity;
  }

  Future<GetGoalIdResponse> getGoalId(String email) async {
    final response =
        await post(Uri.parse("$BASE_URL_8082/goals/summary/create/$email"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              "email": email,
            }));
    final activity = getGoalIdResponseApiFromJson(response.body);
    return activity;
  }

  Future<GetAchieverGoalAreaResponse> getAchieverGoalAreas() async {
    final response = await get(
      Uri.parse("$BASE_URL_8082/goals/summary/areas/achiever"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final activity = getAchieverGoalAreaResponseApiFromJson(response.body);
    return activity;
  }

  Future<GetInfluencerGoalAreaResponse> getInfluencerGoalAreas() async {
    final response = await get(
      Uri.parse("$BASE_URL_8082/goals/summary/areas/influencer"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final activity = getInfluencerGoalAreaResponseApiFromJson(response.body);
    return activity;
  }

  Future<CreateGoalResponse> createMilestone(
      CreateMilestone milestoneBody) async {
    var a = milestoneBody;
    final response =
        await post(Uri.parse("$BASE_URL_8082/api/goals/outcomes/add/outcome"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: createMilestoneApiToJson(milestoneBody));
    final activity = createGoalResponseApiFromJson(response.body);
    return activity;
  }

  Future<CreateGoalResponse> shareGoal(ShareGoal shareGoal) async {
    final response = await post(Uri.parse("$BASE_URL_8082/api/sharegoals/save"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: shareGoalApiToJson(shareGoal));
    final activity = createGoalResponseApiFromJson(response.body);
    return activity;
  }

  Future uploadImage(File? image, String? email) async {
    var stream = ByteStream(image!.openRead());
    stream.cast();
    print(basename(image.path));
    var length = await image.length();
    var uri = Uri.parse("$BASE_URL_8080/api/userprofile/upload/$email");
    var request = MultipartRequest("POST", uri);
    var multipart =
        MultipartFile('file', stream, length, filename: basename(image.path));

    request.files.add(multipart);

    var response = await request.send();

    if (response.statusCode == 200) {
      print("Success");
      return "Success";
    } else {
      print("Failure");
      return "Failure";
    }
  }

  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    final response = await post(Uri.parse("$BASE_URL/api/forgotpw"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "username": email,
        }));
    final activity = forgotPasswordResponseApiFromJson(response.body);
    return activity;
  }

  Future<ForgotPasswordResponse> resetPassword(
      String email, String password, String code) async {
    final response = await post(Uri.parse("$BASE_URL/api/confirmfp"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "username": email,
          "password": password,
          "confirmationCode": code,
        }));
    final activity = forgotPasswordResponseApiFromJson(response.body);
    return activity;
  }

  Future<GetGoalSummary> getGoalSummary(int goalId) async {
    final response = await get(
      Uri.parse("$BASE_URL_8082/goals/summary/$goalId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print("manasa ${response.statusCode}");
    print("manasa ${response.body}");
    final activity = getGoalSummaryApiFromJson(response.body);
    return activity;
  }

  Future<GetMilestone> getGoalOutcomes(int goalId) async {
    final response = await get(
      Uri.parse("$BASE_URL_8082/api/goals/outcomes/get/outcome/$goalId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print("manasa ${response.statusCode}");
    print("manasa ${response.body}");
    final activity = getMilestoneApiFromJson(response.body);
    return activity;
  }

  Future<GetGoalProgress> getGoalProgress(String userName, int goalId, int roleId) async {
    final response = await get(
      Uri.parse("$BASE_URL_8082/goals/progress/$userName/$goalId/$roleId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print("manasa ${response.statusCode}");
    print("manasa ${response.body}");
    final activity = getGoalProgressApiFromJson(response.body);
    return activity;
  }

  Future<UpdateGoalProgress> updateProgress(UpdateGoalProgress progressBody) async {
    final response = await post(Uri.parse("$BASE_URL_8082/goals/progress/save"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: updateGoalProgressApiToJson(progressBody)
        );
    print("manasa role id : ${progressBody.roleId}");
    print("manasa : ${response.statusCode}");
    final activity = updateGoalProgressApiFromJson(response.body);
    return activity;
  }

  Future<GetReviewComments?> getReviewComments(String userName, int goalId) async {
    final response = await get(
      Uri.parse("$BASE_URL_8082/goals/progress/rcomments/$userName/$goalId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if(response.statusCode == 200){
      print("manasa ${response.statusCode}");
      print("manasa ${response.body}");
      final activity = getReviewCommentsApiFromJson(response.body);
      return activity;
    }
    return null;
  }

  Future<int> updateReviewComments(UpdateReviewComments reviewComments) async {
    final response = await post(Uri.parse("$BASE_URL_8082/goals/progress/rcomments"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: updateReviewCommentsApiToJson(reviewComments)
    );
    print("manasa role id : ${reviewComments.roleId}");
    print("manasa : ${response.statusCode}");
    //final activity = updateReviewCommentsApiFromJson(response.body);
    return response.statusCode;
  }

  Future<int> updateMilestone(UpdateMilestone milestone, int goalId, int mileId) async {
    final response = await post(Uri.parse("$BASE_URL_8082/goals/updatemilestone/$goalId/$mileId"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: updateMilestoneApiToJson(milestone)
    );
    print("manasa role id : ${milestone.roleId}");
    print("manasa : ${response.statusCode}");
    return response.statusCode;
  }
}
