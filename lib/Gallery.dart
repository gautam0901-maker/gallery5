import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'main.dart';
import 'package:gallery5/article_model.dart';
class gautam extends StatefulWidget {
  @override
  _gautamState createState() => _gautamState();
}

class _gautamState extends State<gautam> {
  List<String> images = new List();
  ScrollController _scrollController = new ScrollController();
  @override
  void initState(){
    super.initState();
    getImages();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        getImages();

      }
    });
  }
  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView.builder(
            controller: _scrollController,
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index){
              return Container(
                decoration: BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Image.network(images[index],fit: BoxFit.fitWidth,),
              );
            }),
      ),
    );
  }
  fetch ()async{
    final response = await http.get('https://dog.ceo/api/breeds/image/random');
    if (response.statusCode == 200){
      setState(() {
        images.add(json.decode(response.body)['message']);
      });

    }
    else {

      throw Exception('Failed to load images');
    }

  }
  getImages(){
    for(int i=0;i<7;i++){
      fetch();
    }
  }
}
