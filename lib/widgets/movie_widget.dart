import 'package:flutter/material.dart';
import 'package:moonflix/models/movie_simple_model.dart';

class Movie extends StatelessWidget {
  const Movie({
    super.key,
    required this.movie,
  });

  final MovieSimpleModel movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: movie.id,
            child: Container(
              width: 150,
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
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
