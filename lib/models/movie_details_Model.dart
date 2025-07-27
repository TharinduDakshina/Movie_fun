import 'package:flutter/cupertino.dart';
import 'package:movie_fun/models/company_model.dart';

class MovieDetailsModel{
  bool? isAdult;
  String?  tagline;
  List<Company>? company;

  MovieDetailsModel({this.isAdult, this.tagline, this.company});

  factory MovieDetailsModel.fromJson(Map<String, dynamic> data){

    List<Company> companies = (data["production_companies"] as List)
    .map((company)=> Company.fromJson(company)).toList();

    return MovieDetailsModel(
      company: companies,
      isAdult: data["adult"],
      tagline: data["tagline"]
    );
  }
}
