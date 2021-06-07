import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news/helper/data.dart';
import 'package:news/helper/news.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/category_model.dart';

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
      ):Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.0),
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
              padding: EdgeInsets.symmetric(horizontal: 7.0),
              height: 580.0,
              child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context,index){
                  return BlogTile(
                    imageUrl: articles[index].image, 
                    title: articles[index].title, 
                    desc: articles[index].description
                  );
                }
              ),

            )
          ],
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
              child: Image.network(
                imageUrl, width: 120.0, 
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
  final String imageUrl, title, desc;
  const BlogTile({ Key? key,required this.imageUrl,required this.title,required this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Image.network(imageUrl),
        Text(title),
        Text(desc)
      ],),
    );
  }
}