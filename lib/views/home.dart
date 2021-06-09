import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news/helper/data.dart';
import 'package:news/helper/news.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/category_model.dart';
import 'package:news/views/article_view.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<ArticleModel> articles = [];
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews()async{
    News newsClass = News();
    await newsClass.getNews();
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
        elevation: 0.0,
      ),
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ):SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(            
            children: [
              Container(
                height: 70.0,
                child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return CategoryTile(
                      imageUrl: categories[index].imageUrl,
                      categoryName: categories[index].categoryName,
                    );
                  },
                ),
              ),
              //Categories
              Container(
                padding: EdgeInsets.only(top: 16.0),
                height: 580.0,
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
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imageUrl, categoryName;
  CategoryTile({this.imageUrl,this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(right: 5),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: CachedNetworkImage(
                imageUrl: imageUrl, width: 120.0, 
                height: 60.0, 
                fit: BoxFit.cover),),
            Container(
              alignment: Alignment.center,
              width: 120.0,
              height: 60.0,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.0), color: Colors.black26),
              child: Text(categoryName, style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w500),),
            )
          ],
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
