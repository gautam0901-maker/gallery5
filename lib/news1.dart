import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'article_model.dart';
import 'dart:convert';
    class News{
      List<ArticleModel> news = [];
    Future<void> getNews() async{
      String Url = "https://newsapi.org/v2/top-headlines?country=in&apiKey=6c2ae8915e2946fc9da93547c6578250";
      var response = await http.get(Url);
      var jsonData = jsonDecode(response.body);
      if(jsonData['status']== "ok"){
        jsonData ['articles'].forEach( (element){
           if(element['urlToImage'] != null && element['description'] != null){
             ArticleModel articleModel = ArticleModel(
               title: element['title'],
               author: element['author'],
               description: element['description'],
               url: element['url'],
               UrlToImage: element['urlToImage'],

               Content: element['context'],

             );
             news.add(articleModel);

           }
        });
      }
    }
    }