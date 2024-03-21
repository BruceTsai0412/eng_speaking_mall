import 'package:flutter/material.dart';

class Genre_test extends StatelessWidget {
  final String difficulty;

  const Genre_test({Key? key, required this.difficulty}) : super(key: key);

  List<String> getImagePaths(String difficulty) {
    switch (difficulty) {
      case 'Easy':
        return ['image/pos_la_la_land.png', 'image/pos_la_la_land.png', 'image/pos_la_la_land.png', 'image/pos_la_la_land.png'];
      case 'Intermediate':
        return ['image/pos_back_to_the_future.png', 'image/pos_back_to_the_future.png', 'image/pos_back_to_the_future.png', 'image/pos_back_to_the_future.png'];
      case 'Hard':
        return ['image/pos_me_time.png', 'image/pos_me_time.png', 'image/pos_me_time.png', 'image/pos_me_time.png'];
      case 'Phonetics 1':
        return ['image/pos_jumanji.png', 'image/pos_jumanji.png', 'image/pos_jumanji.png', 'image/pos_jumanji.png'];
      case 'Phonetics 2':
        return ['image/pos_me_time.png', 'image/pos_me_time.png', 'image/pos_me_time.png', 'image/pos_me_time.png'];
      default:
        return ['image/pos_la_la_land1png', 'image/pos_la_la_land.png', 'image/pos_la_la_land.png', 'image/pos_la_la_land.png'];}
  }

  @override
  Widget build(BuildContext context) {
    final imagePaths = getImagePaths(difficulty);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
              4,
              (index) {
                return Container(
                  margin: const EdgeInsets.all(5.0),
                  child: Container(
                    width: 100,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(imagePaths[index]),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
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
    );
  }
}