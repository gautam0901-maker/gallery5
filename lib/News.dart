import 'package:flutter/material.dart';
import 'package:gallery5/article_view.dart';
import 'package:gallery5/news1.dart';
import 'article_model.dart';
import 'article_view.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading;
  @override
  void initState(){
    super.initState();
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image:DecorationImage(
              image: AssetImage('images/newsimage3.png'),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Container(

                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                itemCount: articles.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    return BlogTile(
                      imgUrl: articles[index].UrlToImage,
                      title: articles[index].title,
                      desc: articles[index].description,
                      url: articles[index].url,

                    );
                  })
        ),
            ],
          ),
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  @override

  final String imgUrl, title,desc,url;
  BlogTile({@required this.imgUrl,@required this.title,@required this.desc, @required this.url});
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ArticleView(
           blogUrl:url
          ),
        ));
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imgUrl)),
            SizedBox(
              height: 5,
            ),
            Text(title, style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(
              height: 5,
            ),
            Text(desc, style: TextStyle(
              fontSize: 15,

            ),),
          ],
        ),
      ),
    ) ;
  }
}
