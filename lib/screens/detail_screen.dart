import 'package:flutter/material.dart';
import 'package:moonflix/models/movie_detail_simple_model.dart';
import 'package:moonflix/services/movie_api_service.dart';

class DetailScreen extends StatefulWidget {
  final int id;
  final String title, thumb;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MovieDetailSimpleModel> movie;

  @override
  void initState() {
    super.initState();
    movie = ApiService.getMovieById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Hero(
        tag: widget.id,
        child: Container(
          width: 800,
          height: 1200,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: const ColorFilter.mode(
                Colors.grey,
                BlendMode.modulate,
              ),
              // opacity: 0.1,
              // fit: BoxFit.fill,
              image: NetworkImage(
                'https://image.tmdb.org/t/p/w780/${widget.thumb}',
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'Back to list',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  FutureBuilder(
                    future: movie,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        int time = snapshot.data!.runtime;
                        int hour = (time / 60).floor();
                        int minute = (time - hour * 60);
                        var genrelist = snapshot.data!.genres;
                        var genres = '${genrelist[0]['name']}';
                        for (var genre in genrelist.sublist(1)) {
                          genres = '$genres, ${genre['name']}';
                        }

                        String title = snapshot.data!.title;
                        String originalTitle = snapshot.data!.original_title;
                        if (title == originalTitle) {
                          originalTitle = "";
                        } else {
                          originalTitle = '($originalTitle)';
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$title $originalTitle',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            starRate(snapshot.data!.vote_average),
                            Text(
                              '${snapshot.data!.vote_average}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              ' ${hour}h ${minute}min | $genres',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 150,
                            ),
                            const Text(
                              'Storyline',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              snapshot.data!.overview,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        );
                      }
                      return const Text('...');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

SizedBox starRate(double rate) {
  return SizedBox(
    height: 50,
    child: Row(
      children: [
        rate < 1
            ? const Icon(
                Icons.star_outline_outlined,
                color: Colors.amber,
              )
            : rate < 2
                ? const Icon(
                    Icons.star_half_outlined,
                    color: Colors.amber,
                  )
                : const Icon(
                    Icons.star_outlined,
                    color: Colors.amber,
                  ),
        rate < 3
            ? const Icon(
                Icons.star_outline_outlined,
                color: Colors.amber,
              )
            : rate < 4
                ? const Icon(
                    Icons.star_half_outlined,
                    color: Colors.amber,
                  )
                : const Icon(
                    Icons.star_outlined,
                    color: Colors.amber,
                  ),
        rate < 5
            ? const Icon(
                Icons.star_outline_outlined,
                color: Colors.amber,
              )
            : rate < 6
                ? const Icon(
                    Icons.star_half_outlined,
                    color: Colors.amber,
                  )
                : const Icon(
                    Icons.star_outlined,
                    color: Colors.amber,
                  ),
        rate < 7
            ? const Icon(
                Icons.star_outline_outlined,
                color: Colors.amber,
              )
            : rate < 8
                ? const Icon(
                    Icons.star_half_outlined,
                    color: Colors.amber,
                  )
                : const Icon(
                    Icons.star_outlined,
                    color: Colors.amber,
                  ),
        rate < 9
            ? const Icon(
                Icons.star_outline_outlined,
                color: Colors.amber,
              )
            : rate < 10
                ? const Icon(
                    Icons.star_half_outlined,
                    color: Colors.amber,
                  )
                : const Icon(
                    Icons.star_outlined,
                    color: Colors.amber,
                  ),
      ],
    ),
  );
}
