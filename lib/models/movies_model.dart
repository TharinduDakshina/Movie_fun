class Movie{
  String? posterPath;
  String? backdropPath;
  int? id;
  String? title;
  String? overview;

  Movie({this.posterPath, this.backdropPath, this.id, this.title, this.overview});

  factory Movie.fromJson(Map<String,dynamic> map){
    return Movie(
        posterPath: map["poster_path"],
        backdropPath: map["backdrop_path"],
        id: map["id"],
        title: map["title"],
        overview: map["overview"]
    );
  }
}