import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gallery5/config.dart';
import 'package:hive/hive.dart';
import 'Gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:gallery5/article_view.dart';
import 'package:gallery5/news1.dart';
import 'article_model.dart';
import 'article_view.dart';
import 'main.dart';
import 'package:gallery5/news.dart';
void main() async {
  await Hive.initFlutter();

  box  = await Hive.openBox('Themes');
  runApp(MyBottomBar());
}

class MyBottomBar extends StatefulWidget {
  @override
  _MyBottomBarState createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {

  @override
  void init(){

    super.initState();
    currentTheme.addListener(() {
      print('changes');
      setState(() {

      });
    });
  }

  void OnTappedBar(int index){
    setState(() {
      _currentIndex = index;
    });
  }
  int _currentIndex = 0;
  final List<Widget> _children = [

    gautam(),
    Home(),
  ];
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: currentTheme.currentTheme(),
      home: Scaffold(
        floatingActionButton: FloatingActionButton.extended(onPressed: (){

          currentTheme.switchTheme();
        },
          label: Text('SwitchTheme'),
          icon: Icon(Icons.brightness_6),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Gallery And News",
            style: TextStyle(
                fontSize: 26.0),
          ),

          elevation: 0,

        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: OnTappedBar,

          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.radio ,
                color: Colors.orange,
              ),
              title: new Text("News",
                style: TextStyle(
                  color: Colors.orange,

                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.photo,
                color: Colors.orange,
              ),
              title: new Text("Gallery",
                style: TextStyle(
                    color: Colors.orange
                ),
              ),

            ),
          ],
        ),

      ),
    );
  }
}

//New Page
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;
  @override
  void initState(){
    void init(){

      super.initState();
      currentTheme.addListener(() {
        print('changes');
        setState(() {

        });
      });
    }
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
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: currentTheme.currentTheme(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: _loading ? Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          ):Container(

            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Container(

                    decoration: BoxDecoration(

                    ),
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
        decoration: BoxDecoration(

        ),
        padding: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(imageUrl:imgUrl ,)),
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
