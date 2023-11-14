import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'services/build_tools.dart';

void main() {
  runApp(MyApp());
}

class Joke {
  final String category;
  final String joke;

  Joke({required this.category, required this.joke});

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      category: json['category'] ?? 'Unknown',
      joke: json['joke'] ?? 'No joke available',
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke API Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool jokeGood = false;
  MyTools tools = MyTools();
  TextEditingController textController = TextEditingController();

  Future<Joke> fetchJoke() async {
    final response = await http
        .get(Uri.parse('https://v2.jokeapi.dev/joke/Any?type=single'));

    if (response.statusCode == 200) {
      return Joke.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load joke');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Joke API Example'),
      ),
      body: Center(
        child: FutureBuilder<Joke>(
          future: fetchJoke(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Category: ${snapshot.data!.category}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Joke: ${snapshot.data!.joke}',
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: jokeGood,
                          onChanged: (value) {
                            setState(() {
                              jokeGood = value!;
                            });
                          }),
                      tools.buildGreyText('IS JOKE GOOD?'),
                      TextButton(
                          onPressed: () {},
                          child: tools.buildGreyText('click the checkbox')),

                    ],
                  ),
                  SizedBox(
                    height: 100,
                    width: 250,
                    child: tools.buildInputField(textController),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
