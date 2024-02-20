import 'package:flutter/material.dart';
import 'package:moonflix/models/movie_simple_model.dart';
import 'package:moonflix/services/movie_api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<MovieSimpleModel>> popularMovies =
      ApiService.getPopularMovies();

  final Future<List<MovieSimpleModel>> nowPlayingMovies =
      ApiService.getNowPlayingMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Popular Movies',
              style: TextStyle(
                fontSize: 26,
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: popularMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Expanded(
                          child: makeList(snapshot),
                        ),
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            const Text(
              'Now in Cinemas',
              style: TextStyle(
                fontSize: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<MovieSimpleModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      itemBuilder: (context, index) {
        // print(index);
        var movie = snapshot.data![index];
        return GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              Hero(
                tag: movie.id,
                child: Container(
                  width: 500,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 15,
                          offset: const Offset(10, 10),
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ]),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w780/${movie.backdrop_path}',
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Text(
              //   movie.title,
              //   style: const TextStyle(
              //     fontSize: 22,
              //   ),
              // ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}
