import 'package:flutter/material.dart';
import 'package:movie_fun/services/api_services.dart';

import '../models/movies_model.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  ApiService service = ApiService();
  List<Movie> movies =[];
  int page =1;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.menu),
                Text(
                 "TMDB Movies",
                 style: TextStyle(fontSize: 50,fontWeight: FontWeight.w900),
                ),
                Icon(Icons.favorite),
              ],
            ),
            FutureBuilder(
                future: service.getMovies(page: page),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    movies = [...movies,...snapshot.data!];
                    movies = movies.toSet().toList();
                    return GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: movies.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 0.65,
                        ),
                        itemBuilder: (context, index)  {
                          return Column(
                            children: [
                              Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey,
                                      image: DecorationImage(
                                          fit: BoxFit.fitHeight,
                                          image: NetworkImage("https://image.tmdb.org/t/p/w500${movies[index].posterPath}")
                                      )
                                    ),
                                  )
                              ),
                              Text(
                                maxLines: 2,
                                movies[index].title.toString(),
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w700
                                ),
                              )
                            ],
                          );
                        },
                    );
                  }

                  return const Center(child: CircularProgressIndicator());
                },
            ),
            ElevatedButton(
                onPressed: (){
                  setState(() {
                    page++;
                  });
                },
                child: const Text("Load More.")
            )
          ],
        ),
      )

    );
  }
}
