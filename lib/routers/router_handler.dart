import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../views/news_web.dart';

Handler newsWebHandler = Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> url){
    return NewsWeb();
  },
);