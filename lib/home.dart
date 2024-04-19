import 'package:flutter/material.dart';
import 'select_genre.dart';

void main() {
  runApp(
    MyApp()
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
        title: Text('Home'),
      ),
      backgroundColor: Color(0xffffcd45),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Align(
                  alignment: const Alignment(-0.9, 0),
                  child: Text('What\'s New', style: const TextStyle(fontSize: 20.0),),
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
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Align(
                        alignment: Alignment(-0.9, 0),
                        child: Text('Select a level', style: const TextStyle(fontSize: 20.0),),),
                    ),
                    ...List.generate(
                      _levels.length,
                      (index) => InkWell(
                        onTap:() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => selectGenre(difficulty: _levels[index]),
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