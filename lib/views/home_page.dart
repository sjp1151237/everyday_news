import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_news/service/http_apis.dart';
import 'package:flutter_news/views/item_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

List<String> newsId;

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
//    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920);
    return FutureBuilder(
      future: request("homeCate"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Tab> newsTab = new List();
          newsId = new List();
          print(snapshot.data.toString());
          var data = json.decode(snapshot.data.toString());
          List userMap = (data['data'] as List).cast();
          userMap.forEach((val){
            print(val["cid"].toString());
            newsId.add(val["cid"].toString());
            newsTab.add(new Tab(text: val["cname"],));
          });
          TabController tabController = TabController( length: userMap.length, vsync: ScrollableState(),);
          return Scaffold(
              appBar: AppBar(title: Text('天天快报',),
                bottom: TabBar(controller: tabController,
                tabs: newsTab, isScrollable: true,),),
              body: TabBarView(
                  controller: tabController,
                  children: _widgetPage())
          );
        } else {
          return Scaffold(
            appBar: AppBar(title: Text('天天快报'),),
            body: Center(child: Text('加载中...'),),
          );
        }
      },
    );
  }

  List<Widget> _widgetPage() {
    if (newsId.length != 0) {
      List<Widget> listWidget = newsId.map((val) {
        return ItemPage(title: val.toString(),);
      }).toList();

      return listWidget;
    } else {
      return null;
    }
  }

  @override
  bool get wantKeepAlive => true;
}
