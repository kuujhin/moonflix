import 'package:flutter/material.dart';
import 'package:moonflix/models/movie_simple_model.dart';
import 'package:moonflix/screens/detail_screen.dart';

class PopularMovie extends StatelessWidget {
  final MovieSimpleModel movie;

  const PopularMovie({super.key, required this.movie});

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
      child: Column(
        children: [
          Container(
            width: 300,
            height: 168,
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
              // 'https://image.tmdb.org/t/p/w780/${movie.poster_path}',
              width: 400,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
