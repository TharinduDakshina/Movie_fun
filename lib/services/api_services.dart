import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_fun/models/movie_details_Model.dart';

import '../models/movies_model.dart';

class ApiService {
  final apikey= "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1ZGVkMDAyNTg5NWI3NTBmMGM2NjMxMjNlMzAyNWUyNiIsIm5iZiI6MTc1MzE1NTc5Mi45NjEsInN1YiI6IjY4N2YwOGQwMjJjNTc5ZTRmMDM4ZGVjNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.j7Hsj1zG777-WoHh68ogUmTQuqjVLmeahRDOg8JrPYo";
  final popularEndpoint= "https://api.themoviedb.org/3/movie/popular?language=en-US&page=";
  Map<String,String> headers = {
    "Authorization" : "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1ZGVkMDAyNTg5NWI3NTBmMGM2NjMxMjNlMzAyNWUyNiIsIm5iZiI6MTc1MzE1NTc5Mi45NjEsInN1YiI6IjY4N2YwOGQwMjJjNTc5ZTRmMDM4ZGVjNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.j7Hsj1zG777-WoHh68ogUmTQuqjVLmeahRDOg8JrPYo",
    "accept" : "application/json"
  };

  Future<List<Movie>> getMovies({required int page}) async {
    Response response = await get(Uri.parse("$popularEndpoint$page"),headers: headers);
    if(response.statusCode == 200){
      Map<String,dynamic> body = jsonDecode(response.body);
      List<dynamic> data = body['results'] as List;
      List<Movie> movies = data.map((movie)=> Movie.fromJson(movie)).toList();
      return movies;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<MovieDetailsModel> getDetails({required String id}) async {
    Response response = await get(Uri.parse("https://api.themoviedb.org/3/movie/${id}?language=en-US"),headers: headers);
    if(response.statusCode == 200){
      Map<String,dynamic> json = jsonDecode(response.body);
      return MovieDetailsModel.fromJson(json);
    }else{
      throw Exception(response.statusCode);
    }
  }
}