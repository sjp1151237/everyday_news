import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_news/congif/service_url.dart';
import 'package:flutter_news/service/http_apis.dart';
import 'package:flutter_news/views/list_view_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemPage extends StatefulWidget {
  final String title;

  const ItemPage({Key key, this.title}) : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> with AutomaticKeepAliveClientMixin{
  var title;
  int page;
  List<Map> mapVal = [];
  bool isLoading = false; // 是否正在请求数据中
  bool _hasMore = true; // 是否还有更多数据可加载
  int _pageSize = 20; // 页面的索引

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    title = this.widget.title;
    page = 0;
    _getMoreData();
    isLoading = false;
    _scrollController.addListener(() {
      // 如果下拉的当前位置到scroll的最下面
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
          if (page != 1 || mapVal.length != 0) {
            return RefreshIndicator(
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                itemCount: mapVal.length + 1,
                itemBuilder: (context, index) {

                  if (index == mapVal.length) {
                    //return _buildLoadText();
                    return _buildProgressIndicator();
                  } else {
                    //print('itemsitemsitemsitems:${items[index].title}');
                    //return ListTile(title: Text("Index${index}:${items[index].title}"));
                    return _newWidget(index);
                  }

                },
              ),
              onRefresh: _refreshData,
            );

          } else {
            return Center(
                child: Text(
              "loading...",
              style: TextStyle(
                  backgroundColor: Colors.white,
                  fontSize: 16,
                  color: Colors.blue),
            ));
          }
  }

  Widget _newWidget(index) {
    return Material(
      child: InkWell(
        onTap: () {},
        child: ListViewItem(listImg: mapVal[index]['images_url'],time: mapVal[index]['pdate'],webUrl: serviceUrlOnly + mapVal[index]['url'],itemTitle: mapVal[index]['title'],)
      ),
    );
  }

  // 刷新
  Future<Null>  _refreshData() async{
    page = 0;
    setState(() {
      mapVal.clear();
    });
    _getMoreData();
  }
// 上提加载loading的widget,如果数据到达极限，显示没有更多
  Widget _buildProgressIndicator() {
    if (_hasMore) {
      return new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Center(
            child: Column(
              children: <Widget>[
                new Opacity(
                  opacity: 1,
                  child: new CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.blue)),
                ),
                SizedBox(height: 20.0),
                Text(
                  '稍等片刻更精彩...',
                  style: TextStyle(fontSize: 14.0),
                )
              ],
            )
          //child:
        ),
      );
    } else {
      return _buildLoadText();
    }
  }

  // 加载中的提示
  Widget _buildLoadText() {
    return Container(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: Text("数据没有更多了！！！"),
          ),
        ));
  }

  // list探底，执行的具体事件
  Future _getMoreData() async {
    if (!isLoading && _hasMore) {
      // 如果上一次异步请求数据完成 同时有数据可以加载
      if (mounted) {
        setState(() => isLoading = true);
      }
      page++;
      var formPage = {'cid': title, 'count': _pageSize, 'page': page};
      print(formPage.toString());
      //if(_hasMore){ // 还有数据可以拉新
      // ?cid=tuijian&page=2&count=10
      var data = await requestOnly("http://toutiao.7junshi.com/api360/article_new.php?cid=${title}&page=${page}&count=${_pageSize}");
      var val = json.decode(data.toString());
      List<Map> userMap = (val['data'] as List).cast();

      _hasMore = (_pageSize == userMap.length);
      if (this.mounted) {
        setState(() {
          print("获取数据的个数======"+userMap.length.toString() + "   参数=== " + title);
          mapVal.addAll(userMap);
          isLoading = false;
        });
      }
    } else if (!isLoading && !_hasMore) {
      // 这样判断,减少以后的绘制
//      _pageIndex = 0;
//      backElasticEffect();
    }
  }

  @override
  bool get wantKeepAlive => true;
}
