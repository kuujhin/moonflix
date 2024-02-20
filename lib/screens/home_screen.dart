import 'package:flutter/material.dart';
import 'package:moonflix/models/movie_simple_model.dart';
import 'package:moonflix/services/movie_api_service.dart';
import 'package:moonflix/widgets/movie_widget.dart';
import 'package:moonflix/widgets/popular_movie_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<MovieSimpleModel>> popularMovies =
      ApiService.getPopularMovies();

  final Future<List<MovieSimpleModel>> nowPlayingMovies =
      ApiService.getNowPlayingMovies();

  final Future<List<MovieSimpleModel>> comingSoonMovies =
      ApiService.getComingSoonMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
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
              SizedBox(
                height: 270,
                child: FutureBuilder(
                  future: popularMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return makeMovieList(snapshot, true);
                    }
                    return const SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Now in Cinemas',
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
              SizedBox(
                height: 270,
                child: FutureBuilder(
                  future: popularMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: makeMovieList(snapshot, false),
                          ),
                        ],
                      );
                    }
                    return const SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Coming Soon',
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
              SizedBox(
                height: 270,
                child: FutureBuilder(
                  future: comingSoonMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: makeMovieList(snapshot, false),
                          ),
                        ],
                      );
                    }
                    return const SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView makeMovieList(
      AsyncSnapshot<List<MovieSimpleModel>> snapshot, popular) {
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
        return popular ? PopularMovie(movie: movie) : Movie(movie: movie);
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}
