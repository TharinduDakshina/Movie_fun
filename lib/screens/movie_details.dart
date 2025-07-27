import 'package:flutter/material.dart';
import 'package:movie_fun/models/movie_details_Model.dart';
import 'package:movie_fun/models/movies_model.dart';
import 'package:movie_fun/services/api_services.dart';

class MovieDetails extends StatefulWidget {
  Movie movie;
  MovieDetails({required this.movie,super.key});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  ApiService service = ApiService();
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
       body: FutureBuilder(
           future: service.getDetails(id: widget.movie.id.toString()),
           builder: (context, snapshot) {
             if(snapshot.hasData){
               MovieDetailsModel data = snapshot.data!;
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: size.height*0.25,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(
                            "https://image.tmdb.org/t/p/w500/${widget.movie.backdropPath}"
                        )),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.movie.title.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: size.width * 0.4,
                            height: size.width *0.6,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: NetworkImage("https://image.tmdb.org/t/p/w500/${widget.movie.posterPath}"
                                    )
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.movie.overview.toString(),
                        style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),
                      ),
                    ),
                    const Text(
                      "Production Companies",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            data.company!.length,
                            (index) => data.company![index].logo.toString() == ""
                            ? const SizedBox()
                                : Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.network(
                                      "https://image.tmdb.org/t/p/w500/${data.company![index].logo.toString()}",
                                      width: 120,
                                      height: 100,
                                      fit: BoxFit.fitWidth,
                                    ),
                                    Text(data.company![index].name.toString())
                                  ],
                                ),
                              ),
                            )
                        ),
                      )
                    )
                  ],
                );
             }
             return const Center(
               child: CircularProgressIndicator(),
             );
           },
       )
    );
  }
}
