import 'package:flutter/material.dart';
import 'movie2.dart';

  class MovieData {
    final List<String> movieTitles;
    final List<String> imagePaths;


    MovieData(this.movieTitles, this.imagePaths);
  }

  MovieData getMovieData(String difficulty) {
    switch (difficulty) {
      case 'Easy':
        return MovieData(
          ['Bucket List',
          'Charlie and the Chocolate\n                Factory',
          'The Princess Diaries',
          'Titanic'],
          ['image/pos_bucket_list.png',
          'image/pos_charlie_and_the_chocolate_factory.png',
          'image/pos_the_princess_diaries.png',
          'image/pos_titanic.png'],
        );
      case 'Intermediate':
        return MovieData(
          ['Jurassic Park',
          'Notting Hill',
          'Soul',
          'The Hunger Games'],
          ['image/pos_jurassic_park.png',
          'image/pos_notting_hill.png',
          'image/pos_soul.png',
          'image/pos_the_hunger_games.png'],
        );
      case 'Hard':
        return MovieData(
          ['Men In Black',
          'Back to the Future',
          'Inception',
          'Inside Out'],
          ['image/pos_mib.png',
          'image/pos_back_to_the_future.png',
          'image/pos_inception.png',
          'image/pos_inside_out.png'],
        );
      default:
        throw Exception('Invalid difficulty: $difficulty');
    }
  }

class selectMovie extends StatefulWidget {
  final String difficulty;

  const selectMovie({super.key, required this.difficulty});

  @override
  _selectMovie createState() => _selectMovie();
}

class _selectMovie extends State<selectMovie> {
  late MovieData _movieData;

  @override
  void initState() {
    super.initState();
    _movieData = getMovieData(widget.difficulty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Movie'),
      ),
      backgroundColor: const Color(0xFFFFCD45),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              _movieData.movieTitles.length ~/ 2,
              (index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildMovieContainer(_movieData.movieTitles[2 * index], _movieData.imagePaths[2 * index], index * 2, context),
                  buildMovieContainer(_movieData.movieTitles[2 * index + 1], _movieData.imagePaths[2 * index + 1], index * 2 + 1, context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column buildMovieContainer(String title, String imagePath, int index, BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(12, 50, 12, 10),
          child: Column(
            children: [
              Image.asset(
                imagePath,
                height: 190.0,
                width: 180.0,
              ),
              const SizedBox(height: 6.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 35.0,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Movie(movieName: _movieData.movieTitles[index], imagePath: _movieData.imagePaths[index])),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF264683)),
            child: const Text('Select', style: TextStyle(color: Color(0xffffffff),),),
          ),
        ),
      ],
    );
  }
}