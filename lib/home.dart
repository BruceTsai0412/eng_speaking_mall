import 'package:flutter/material.dart';
import 'select_movie.dart';

void main() {
  runApp(
    const MyApp()
  );
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speaking Learning App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<String> _levels = [
    'Easy',
    'Intermediate',
    'Hard',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      backgroundColor: const Color(0xffffcd45),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Align(
                  alignment: Alignment(-0.9, 0),
                  child: Text('What\'s New', style: TextStyle(fontSize: 20.0),),
                ),
              ),
              const SizedBox.shrink(),
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'image/support_us.png',
                      height: 180.0,
                      width: 350.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Align(
                        alignment: Alignment(-0.9, 0),
                        child: Text('Select a level', style: TextStyle(fontSize: 20.0),),),
                    ),
                    ...List.generate(
                      _levels.length,
                      (index) => InkWell(
                        onTap:() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => selectMovie(difficulty: _levels[index]),
                            ),
                          ); 
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xfffcf3e3),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.black,
                              width: 1.5,
                            ),
                          ),
                          padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                          margin: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _levels[index],
                                      style: const TextStyle(fontSize: 20.0, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}