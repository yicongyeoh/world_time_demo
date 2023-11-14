import 'package:http/http.dart';
import 'dart:convert';

class Article {
  late String author;
  late String title;
  late String description;
  late String newsUrl;
  late String imgUrl;

  Article({
    required this.author,
    required this.title,
    required this.description,
    required this.newsUrl,
    required this.imgUrl,
  });
}

class NewsAPI {
  late List<Article> articles;

  Future<void> getNews(country) async {
    //country = 'my';
    try {
      Response response = await get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=$country&apiKey=72b5b594568d489f815624b4856d570d'));
      Map data = jsonDecode(response.body);
      print(data);

      if (data['status'] == 'ok') {
        // If the response status is 'ok', parse the articles
        articles = (data['articles'] as List)
            .map((article) => Article(
                  author: article['author'] ?? '',
                  title: article['title'] ?? '',
                  description: article['description'] ?? '',
                  newsUrl: article['url'] ?? '',
                  imgUrl: article['urlToImage'] ?? 'https://upload.wikimedia.org/wikipedia/commons/thumb/archive/5/59/20230311130802%21Minecraft_missing_texture_block.svg/120px-Minecraft_missing_texture_block.svg.png',
                ))
            .toList();
      } else {
        throw Exception('API request failed');
      }
    } catch (e) {
      // Handle errors
      print('Error: $e');
      articles = [];
    }
  }
}
