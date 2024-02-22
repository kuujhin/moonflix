import 'package:flutter/material.dart';
import 'package:moonflix/models/movie_simple_model.dart';
import 'package:moonflix/services/movie_api_service.dart';
import 'package:moonflix/widgets/movie_widget.dart';
import 'package:moonflix/widgets/popular_movie_widget.dart';
// import 'package:shared_preferences/shared_preferences.dart';

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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Future<List<MovieSimpleModel>> popularMovies =
      ApiService.getPopularMovies();

  final Future<List<MovieSimpleModel>> nowPlayingMovies =
      ApiService.getNowPlayingMovies();

  final Future<List<MovieSimpleModel>> comingSoonMovies =
      ApiService.getComingSoonMovies();

  // late SharedPreferences prefs;
  bool darkMode = false;

  onModeChange() async {
    // prefs = await SharedPreferences.getInstance();
    // final mode = prefs.getBool('mode');
    // if (mode != null) {
    setState(() {
      darkMode = !darkMode;
    });
    // } else {
    //   prefs.setBool('mode', false);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(
          "KuuFlix1",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: darkMode ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        // foregroundColor: Colors.green,
        backgroundColor: darkMode ? Colors.black : Colors.white,
        // surfaceTintColor: Colors.white,
        // shadowColor: Colors.black,
        // elevation: 3,
        actions: [
          IconButton(
            onPressed: onModeChange,
            icon: Icon(
              darkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ScrollConfiguration(
          behavior: MyCustomScrollBehavior(),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title('Popular Movies', darkMode),
                SizedBox(
                  height: 270,
                  child: FutureBuilder(
                    future: popularMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return makeMovieList(snapshot, true, darkMode);
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                title('Now in Cinemas', darkMode),
                SizedBox(
                  height: 360,
                  child: FutureBuilder(
                    future: nowPlayingMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return makeMovieList(snapshot, false, darkMode);
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                title('Coming Soon', darkMode),
                SizedBox(
                  height: 360,
                  child: FutureBuilder(
                    future: comingSoonMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return makeMovieList(snapshot, false, darkMode);
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
      AsyncSnapshot<List<MovieSimpleModel>> snapshot, popular, darkMode) {
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
        return popular
            ? PopularMovie(movie: movie)
            : Movie(movie: movie, mode: darkMode);
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }

  Text title(String text, bool darkMode) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: darkMode ? Colors.white : Colors.black,
      ),
    );
  }
}
