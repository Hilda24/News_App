import 'dart:convert';

import 'package:news/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'package:news/views/category_news.dart';



class News{
  List<ArticleModel> news = [];
  Future<void> getNews() async{
    const URL = "https://newsapi.org/v2/top-headlines?country=in&apiKey=142af6f738fa4b8aba31df541430fa9f";
    var response = await http.get(Uri.parse(URL));
    var jsonData = jsonDecode(response.body);
    if (jsonData["status"] == "ok")
      jsonData["articles"].forEach((Element){
        if (Element["urlToImage"] != "" && Element["description"] != "" && Element["author"] != null){
          ArticleModel articleModel = ArticleModel(
            title: Element["title"],
            description: Element["description"],
            author: Element["author"],
            image: Element["urlToImage"],
            url: Element["url"],
            // publishedat: Element["publishedAt"],
            content: Element["content"],
          );

          news.add(articleModel);
        } 
      });
    }
  }

  class CategoryNewsClass{
  List<ArticleModel> news = [];
  Future<void> getNews(String category) async{
    String URL = "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=142af6f738fa4b8aba31df541430fa9f";
    var response = await http.get(Uri.parse(URL));
    var jsonData = jsonDecode(response.body);
    if (jsonData["status"] == "ok")
      jsonData["articles"].forEach((Element){
        if (Element["urlToImage"] != "" && Element["description"] != "" && Element["content"] != null && Element["author"] != null){
          ArticleModel articleModel = ArticleModel(
            title: Element["title"],
            description: Element["description"],
            author: Element["author"],
            image: Element["urlToImage"],
            url: Element["url"],
            // publishedat: Element["publishedAt"],
            content: Element["content"],
          );

          news.add(articleModel);
        } 
      });
    }
  }
