import 'package:flutter/material.dart';
import 'vid_test2.0.dart';

class Genre1Scene extends StatelessWidget {
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
                  child: Text('Movie_1', style: const TextStyle(fontSize: 20.0),),
                ),
              ),
              Center(
                child: Image.asset(
                  'image/pos_la_la_land.png',
                  height: 240.0,
                  width: 180.0,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16.0),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VideoTest2()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset(
                        'image/test_vid_thumbnail.png',
                        height: 200.0,
                        width: 340.0,
                      ),
                      SizedBox(height: 6.0),
                      Text(
                        'Genre 1 Scene',
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}