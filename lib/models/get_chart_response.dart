import 'dart:convert';

GetChartResponse getChartResponseApiFromJson(String str) =>
    GetChartResponse.fromJson(json.decode(str));
String getChartResponseApiToJson(GetChartResponse data) =>
    json.encode(data.toJson());

class GetChartResponse {
  GetChartResponse({
    required this.responseStatus,
    required this.responseMessage,
    required this.currentRatingChart,
    required this.overallRatingChart,
    required this.ratingChartTrends,
  });
  late final int responseStatus;
  late final String responseMessage;
  late final CurrentRatingChart currentRatingChart;
  late final OverallRatingChart overallRatingChart;
  late final RatingChartTrends ratingChartTrends;

  GetChartResponse.fromJson(Map<String, dynamic> json){
    responseStatus = json['responseStatus'];
    responseMessage = json['responseMessage'];
    currentRatingChart = CurrentRatingChart.fromJson(json['currentRatingChart']);
    overallRatingChart = OverallRatingChart.fromJson(json['overallRatingChart']);
    ratingChartTrends = RatingChartTrends.fromJson(json['ratingChartTrends']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['responseStatus'] = responseStatus;
    _data['responseMessage'] = responseMessage;
    _data['currentRatingChart'] = currentRatingChart.toJson();
    _data['overallRatingChart'] = overallRatingChart.toJson();
    _data['ratingChartTrends'] = ratingChartTrends.toJson();
    return _data;
  }
}

class CurrentRatingChart {
  CurrentRatingChart({
    required this.data,
  });
  late final List<Data> data;

  CurrentRatingChart.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.parameters,
    required this.rating,
  });
  late final int id;
  late final String parameters;
  late final double? rating;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    parameters = json['parameters'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['parameters'] = parameters;
    _data['rating'] = rating;
    return _data;
  }
}

class OverallRatingChart {
  OverallRatingChart({
    required this.data,
  });
  late final List<Data> data;

  OverallRatingChart.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class RatingChartTrends {
  RatingChartTrends({
    required this.monthsLabel,
    required this.bar,
    required this.line,
  });
  late final List<String> monthsLabel;
  late final List<Bar> bar;
  late final List<num> line;

  RatingChartTrends.fromJson(Map<String, dynamic> json){
    monthsLabel = List.castFrom<dynamic, String>(json['monthsLabel']);
    bar = List.from(json['bar']).map((e)=>Bar.fromJson(e)).toList();
    line = List.castFrom<dynamic, num>(json['line']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['monthsLabel'] = monthsLabel;
    _data['bar'] = bar.map((e)=>e.toJson()).toList();
    _data['line'] = line;
    return _data;
  }
}

class Bar {
  Bar({
    required this.id,
    required this.parameter,
    required this.ratings,
    required this.months,
  });
  late final int id;
  late final String parameter;
  late final List<num> ratings;
  late final List<String> months;

  Bar.fromJson(Map<String, dynamic> json){
    id = json['id'];
    parameter = json['parameter'];
    ratings = List.castFrom<dynamic, num>(json['ratings']);
    months = List.castFrom<dynamic, String>(json['months']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['parameter'] = parameter;
    _data['ratings'] = ratings;
    _data['months'] = months;
    return _data;
  }
}