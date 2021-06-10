import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news/helper/data.dart';
import 'package:news/models/article_model.dart';
import 'package:news/helper/news.dart';
import 'package:news/views/article_view.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  const CategoryNews({ Key? key, required this.category}) : super(key: key);

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = [];
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // categories = getCategories();
    getCategoryNews();
  } 
  getCategoryNews()async{
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Dangfanq Lemon News", style: TextStyle(color: Colors.red),)
          ],
        ),
        actions: [Opacity(
          opacity: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(Icons.sd_card_alert_rounded),
          ),
        )],
        elevation: 0.0,
      ),
      body:_loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ):SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(children: [
            Container(
                  padding: EdgeInsets.only(top: 16.0),
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: articles.length,
                    itemBuilder: (context,index){
                      return BlogTile(
                        imageUrl: articles[index].image, 
                        title: articles[index].title, 
                        desc: articles[index].description,
                        url: articles[index].url
                      );
                    }
                  ),
                )
          ],),
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  const BlogTile({ Key? key,required this.imageUrl,required this.title,required this.desc,required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)
          ));
      },
      child: Container(
        child: Column(children: [
          Image.network(imageUrl),
          Text(title, style: TextStyle(fontSize: 17.0, color: Colors.black87),),
          Text(desc, style: TextStyle(color: Colors.grey),)
        ],),
      ),
    );
  }
}