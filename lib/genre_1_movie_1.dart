import 'package:flutter/material.dart';
import 'practice.dart';

class Genre1Scene extends StatelessWidget {
  final String movieName;
  final String imagePath;

  Genre1Scene({required this.movieName, required this.imagePath});

  final Map<String, List<String>> videoThumbnails = {
    'La La Land': ['image/test_vid_thumbnail.png', 'image/test_vid_thumbnail.png'],
    'Love Happens': ['image/test_vid_thumbnail_1.png', 'image/test_vid_thumbnail_2.png'],
    'Titanic': ['image/test_vid_thumbnail_1.png', 'image/test_vid_thumbnail_2.png'],
    'Movie title 4': ['image/test_vid_thumbnail_1.png', 'image/test_vid_thumbnail_2.png'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genre1Scene'),
      ),
      backgroundColor: Color(0xFFFFCD45),
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
              SizedBox(height: 16.0),
              ...List.generate(
                videoThumbnails[movieName]!.length,
                (index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Practice()),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.asset(
                            videoThumbnails[movieName]![index],
                            height: 200.0,
                            width: 340.0,
                          ),
                          SizedBox(height: 6.0),
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