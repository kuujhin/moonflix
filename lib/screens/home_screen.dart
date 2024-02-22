import 'package:flutter/material.dart';
import 'package:moonflix/models/movie_simple_model.dart';
import 'package:moonflix/services/movie_api_service.dart';
import 'package:moonflix/widgets/movie_widget.dart';
import 'package:moonflix/widgets/popular_movie_widget.dart';

import 'package:flutter/gestures.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

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
      appBar: AppBar(
        title: const Text(
          "MoonFlix",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 3,
      ),
      body: SingleChildScrollView(
        child: ScrollConfiguration(
          behavior: MyCustomScrollBehavior(),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title('Popular Movies'),
                SizedBox(
                  height: 270,
                  child: FutureBuilder(
                    future: popularMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return makeMovieList(snapshot, true);
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                title('Now in Cinemas'),
                SizedBox(
                  height: 270,
                  child: FutureBuilder(
                    future: nowPlayingMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return makeMovieList(snapshot, false);
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                title('Coming Soon'),
                SizedBox(
                  height: 270,
                  child: FutureBuilder(
                    future: comingSoonMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return makeMovieList(snapshot, false);
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ],
            ),
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

  Text title(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 26,
      ),
    );
  }
}
