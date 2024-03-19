import 'dart:ui';

import 'package:mycareteam/models/flags_and_code.dart';

import 'colors.dart';

List<FlagsAndCode> countries = [
  FlagsAndCode(svg: "au", code: "+61"),
];

List<String> countriesStings = ["Select Country", "Australia"];
List<String> goalRecurring = ["Daily", "Weekly", "Monthly", "Yearly"];
List<String> goalSummaryRecurring = ["Select recurring frequency *", "Daily", "Weekly", "Monthly", "Yearly"];
List<String> progressPercent = [
  "10%",
  "20%",
  "30%",
  "40%",
  "50%",
  "60%",
  "70%",
  "80%",
  "90%",
  "100%"
];
List<String> yesNo = ["Yes", "No"];
List<String> peopleRole = [
  "Select Role",
  "Nominated",
  "Primary Contact",
  "Secondary Contact",
  "Others"
];
List<String> peoplePermissions = ["View access", "Frequency of Notification"];
List<String> genders = ["Male", "Female"];
List<String> hours = [
  "00 H",
  "01 H",
  "02 H",
  "03 H",
  "04 H",
  "05 H",
  "06 H",
  "07 H",
  "08 H",
  "09 H",
  "10 H",
  "11 H",
  "12 H",
  "13 H",
  "14 H",
  "15 H",
  "16 H",
  "17 H",
  "18 H",
  "19 H",
  "20 H",
  "21 H",
  "22 H",
  "23 H"
];

List<String> minutes = [
  "00 M",
  "01 M",
  "02 M",
  "03 M",
  "04 M",
  "05 M",
  "06 M",
  "07 M",
  "08 M",
  "09 M",
  "10 M",
  "11 M",
  "12 M",
  "13 M",
  "14 M",
  "15 M",
  "16 M",
  "17 M",
  "18 M",
  "19 M",
  "20 M",
  "21 M",
  "22 M",
  "23 M",
  "24 M",
  "25 M",
  "26 M",
  "27 M",
  "28 M",
  "29 M",
  "30 M",
  "31 M",
  "32 M",
  "33 M",
  "34 M",
  "35 M",
  "36 M",
  "37 M",
  "38 M",
  "39 M",
  "40 M",
  "41 M",
  "42 M",
  "43 M",
  "34 M",
  "45 M",
  "46 M",
  "47 M",
  "48 M",
  "49 M",
  "50 M",
  "51 M",
  "52 M",
  "53 M",
  "54 M",
  "55 M",
  "56 M",
  "57 M",
  "58 M",
  "59 M"
];

String tc =
    "Please read these terms and conditions carefully before using Our Service.";
String termsAndCondition =
    "The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.";

String purpose =
    "  *  Application means the software program provided by the Company downloaded by You on any electronic device, named MyCareteam.Online\n\n" +
    "  *  Application Store means the digital distribution service operated and developed by Apple Inc. (Apple App Store) or Google Inc. (Google Play Store) in which the Application has been downloaded.\n\n" +
    "  *  Affiliate means an entity that controls, is controlled by or is under common control with a party, where \"control\" means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority.\n\n" +
    "  *  Account means a unique account created for You to access our Service or parts of our Service.\n\n" +
    "  *  Country refers to: Victoria, Australia\n\n" +
    "  *  Company (referred to as either \"the Company\", \"We\", \"Us\" or \"Our\" in this Agreement) refers to Four Square Venture Holdings , 3 Bravo Loop, Pakenham, Victoria, 3810.\n\n" +
    "  *  Content refers to content such as text, images, or other information that can be posted, uploaded, linked to or otherwise made available by You, regardless of the form of that content.";

String interpretation = "Interpretation";
String definition = "Definitions";

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

List<RiskAnalysis> riskAnalysis = [
  RiskAnalysis(assetName: "lib/resources/images/timeline_ahead.png", analysis: "Before or ahead of time"),
  RiskAnalysis(assetName: "lib/resources/images/timeline_notOnTrack.png", analysis: "Not on track"),
  RiskAnalysis(assetName: "lib/resources/images/timeline_miss.png", analysis: "Will miss timeline"),
  RiskAnalysis(assetName: "lib/resources/images/timeline_finish.png", analysis: "Right on time")
];

List<MilestoneStatus> milestoneStatus = [
  MilestoneStatus(status: "Not Started", colour: goalCategoryGrey),
  MilestoneStatus(status: "Pending", colour: goalCategoryRed),
  MilestoneStatus(status: "In Progress", colour: goalCategoryProgress),
  MilestoneStatus(status: "Completed", colour: goalCategoryGreen)
];

class RiskAnalysis{
  RiskAnalysis({
    required this.assetName,
    required this.analysis
  });
  String assetName;
  String analysis;
}

class MilestoneStatus{
  MilestoneStatus({
    required this.status,
    required this.colour
  });
  String status;
  Color colour;
}
