import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(gautam());
}
class gautam extends StatefulWidget {
  @override
  _gautamState createState() => _gautamState();
}

class _gautamState extends State<gautam> {
  bool themeSwitch = false;

  dynamic themeColors() {
    if (themeSwitch) {
      return Colors.grey[850];
    } else {
      return Colors.white54;
    }
  }
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
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Gallery",
            style: TextStyle(
                color: themeSwitch
                    ? Colors.white
                    : Colors.grey[850],
                fontSize: 26.0),
          ),
          backgroundColor: themeColors(),
          elevation: 0,
          brightness: themeSwitch ? Brightness.dark : Brightness.light,
          leading: IconButton(
            onPressed: () {
              setState(() {
                themeSwitch = !themeSwitch;
              });
            },
            icon: themeSwitch
                ? Icon(
              Icons.brightness_3,
              color: themeSwitch ? Colors.white : Colors.grey[850],
            )
                : Icon(
              Icons.wb_sunny,
              color: themeSwitch ? Colors.greenAccent : Colors.grey[850],
            ),
          ),
        ),
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
