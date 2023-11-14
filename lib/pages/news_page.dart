import 'package:flutter/material.dart';
import 'package:world_time_demo/services/news_api.dart';
import 'package:url_launcher/url_launcher.dart';


void main() {
  runApp(MaterialApp(home: NewsPage()));
}

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final NewsAPI newsApi = NewsAPI();

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    await newsApi.getNews('my'); // Replace 'us' with the desired country code
    setState(() {}); // Trigger a rebuild
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Directionality(
        textDirection: TextDirection.ltr, // or TextDirection.rtl
        child: Scaffold(
          appBar: AppBar(
            title: Text('News App'),
          ),
          body: _buildNewsList(),
        ),
      ),
    );
  }

  Widget _buildNewsList() {
    if (newsApi.articles.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        itemCount: newsApi.articles.length,
        itemBuilder: (context, index) {
          final article = newsApi.articles[index];
          return ListTile(
            leading: CircleAvatar(
              // Display the article image in a CircleAvatar
              backgroundImage: NetworkImage(article.imgUrl),
            ),
            title: Text(article.title),
            subtitle: Text(article.description),
            onTap: () {
              // Handle tapping on the article, e.g., navigate to a detailed view
              _navigateToArticleDetail(article.newsUrl);
            },
          );
        },
      );
    }
  }
}

Future<void> _navigateToArticleDetail(String url) async {
  Uri _url = Uri.parse(url);

  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
