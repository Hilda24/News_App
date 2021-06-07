import 'dart:convert';

import 'package:news/models/article_model.dart';
import 'package:http/http.dart' as http;


class News{
  List<ArticleModel> news = [];
  Future<void> getNews() async{
    //  URL = https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=142af6f738fa4b8aba31df541430fa9f;
    // var response = await http.get("https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=142af6f738fa4b8aba31df541430fa9f");
    // var jsonData = jsonDecode(response.body);
  }
}