import 'package:flutter/material.dart';
import 'package:moonflix/models/movie_simple_model.dart';

class PopularMovie extends StatelessWidget {
  const PopularMovie({
    super.key,
    required this.movie,
  });

  final MovieSimpleModel movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Hero(
            tag: movie.id,
            child: Container(
              width: 300,
              height: 200,
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
                width: 400,
                height: 250,
                fit: BoxFit.cover,
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
  }
}
