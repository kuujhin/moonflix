import 'package:flutter/material.dart';
import 'package:moonflix/models/movie_simple_model.dart';
import 'package:moonflix/screens/detail_screen.dart';

class Movie extends StatelessWidget {
  final MovieSimpleModel movie;
  final bool mode;

  const Movie({super.key, required this.movie, required this.mode});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              id: movie.id,
              title: movie.title,
              // thumb: movie.backdrop_path,
              thumb: movie.poster_path,
            ),
            // fullscreenDialog: true,
          ),
        );
      },
      child: SizedBox(
        height: 330,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 200,
              height: 300,
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
                'https://image.tmdb.org/t/p/w780/${movie.poster_path}',
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 200,
              child: Text(
                movie.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: mode ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
