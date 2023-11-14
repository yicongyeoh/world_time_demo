import 'package:flutter/material.dart';
import 'package:world_time_demo/pages/home.dart';
import 'package:world_time_demo/pages/loading.dart';
import 'package:world_time_demo/pages/choose_location.dart';
import 'package:world_time_demo/test.dart';
import 'pages/news_page.dart';

void main() {
  runApp(MaterialApp(
//    home: Home(),
  initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/location': (context) => ChooseLocation(),
      '/test' : (context) => MyApp(),
      '/news' : (context) => NewsPage(),
    },
  ));
}
