import 'package:flutter/material.dart';
import 'practice3.dart';

class Movie extends StatelessWidget {
  final String movieName;
  final String imagePath;
  final Map<String, List<String>> videoThumbnails = {
    'Bucket List': ['image/thumbnail_bucket_list.png'],
    'Charlie and the Chocolate\n                Factory': ['image/thumbnail_chocolate_factory.png'],
    'The Princess Diaries': ['image/thumbnail_princess_b.png', 'image/thumbnail_princess_a.png'], 
    'Titanic': ['image/thumbnail_titanic_b.png', 'image/thumbnail_titanic_a.png'],
    'Jurassic Park': ['image/thumbnail_jurassic_park_a.png', 'image/thumbnail_jurassic_park_b.png'],
    'Notting Hill': ['image/thumbnail_notting_hill_A.png', 'image/thumbnail_notting_hill_B.png'],
    'Soul': ['image/thumbnail_soul_a.png', 'image/thumbnail_soul_a.png'],
    'The Hunger Games': ['image/thumbnail_the_hunger_games_a.png', 'image/thumbnail_the_hunger_games_b.png'],
    'Men In Black': ['image/thumbnail_mib_a.png', 'image/thumbnail_mib_b.png'],
    'Back to the Future': ['image/thumbnail_back_to_the_future_a.png', 'image/thumbnail_back_to_the_future_b.png'],
    'Inception': ['image/thumbnail_inception_b.png', 'image/thumbnail_inception_a.png'],
    'Inside Out': ['image/thumbnail_inside_out_a.png', 'image/thumbnail_inside_out_b.png'],
  };

  Movie({super.key, required this.movieName, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    int sceneNumber = 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie'),
      ),
      backgroundColor: const Color(0xFFFFCD45),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Align(
                  alignment: const Alignment(-0.9, 0),
                  child: Text(movieName, style: const TextStyle(fontSize: 20.0),),
                ),
              ),
              Center(
                child: Image.asset(
                  imagePath,
                  height: 290.0,
                  width: 210.0,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16.0),
            ...List.generate(
                videoThumbnails[movieName]!.length,
                (index) {
                  return InkWell(
                    onTap: () {
                        print('movieName: $movieName');
                        print('sceneNumber: $sceneNumber');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Practice3(movieName: movieName, sceneNumber: sceneNumber + index)),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.asset(
                            videoThumbnails[movieName]![index],
                            height: 200.0,
                            width: 340.0,
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            'Scene ${index + 1}',
                              style: const TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}