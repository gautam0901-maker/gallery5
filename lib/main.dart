import 'dart:convert';
import 'News.dart';
import 'package:flutter/material.dart';
import 'Gallery.dart';

bool themeSwitch = false;
void main() {
  runApp(MyBottomBar());
}
class MyBottomBar extends StatefulWidget {
  @override
  _MyBottomBarState createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {

  @override


  dynamic themeColors() {
    if (themeSwitch) {
      return Colors.grey[850];
    } else {
      return Colors.white54;
    }

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
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Gallery And News",
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
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: OnTappedBar,
          backgroundColor: themeColors(),
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.photo,
                color: themeSwitch ? Colors.white : Colors.grey[850] ,
              ),
              title: new Text("Gallery",
                style: TextStyle(
                  color: themeSwitch
                      ? Colors.white
                      : Colors.grey[850],
                ),
              ),

            ),
            BottomNavigationBarItem(
              backgroundColor: themeColors(),
              icon: new Icon(Icons.radio ,
                color: themeSwitch ? Colors.white : Colors.grey[850] ,
              ),
              title: new Text("News",
                style: TextStyle(
                  color: themeSwitch
                      ? Colors.white
                      : Colors.grey[850],
                ),
              ),
            )
          ],
        ),

      ),
    );
  }
}
