import 'package:flutter/material.dart';
import 'package:flutter_news/views/news_web.dart';
import 'dart:core';
import 'package:flutter_news/widgets/nove_cover_img.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListViewItem extends StatelessWidget {
  final String webUrl;
  final String imgUrl;
  final String itemTitle;
  final String data;
  final String time;
  final double mWidth, mHeight;
  final List<dynamic> listImg;

  const ListViewItem(
      {Key key,
      this.webUrl,
      this.imgUrl,
      this.itemTitle,
      this.data,
      this.time,
      this.listImg,
      this.mWidth,
      this.mHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920)..init(context);

    double itemWidth = ScreenUtil().setWidth((ScreenUtil().width - 50) / 3);
    double itemHeight = itemWidth * 0.56;

    print(itemWidth.toString() + "    宽高的设定     " + itemHeight.toString());
    return _backWidget(context,listImg, itemWidth, itemHeight);
  }

  Widget _backWidget(BuildContext context,List<dynamic> listImg, double itemWidth, double itemHeight) {
    if (listImg.length == 1 || listImg.length == 2) {
      return InkWell(onTap: () {
        print(webUrl);
        Navigator.of(context).push(
            MaterialPageRoute(
                builder:(BuildContext context){
                  return NewsWeb(webUrl: webUrl,mTitle: itemTitle,);
                }));
//          Application.router.navigateTo(context, '${Routes.webPage}?url=${webUrl}');
      },child: Container(
          margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            children: <Widget>[
              Container(
                height: itemHeight,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Stack(
                            children: <Widget>[
                              Positioned(left: 0.0,top: 0.0,child: Text(
                                itemTitle,
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),),
                              Positioned(left: 0.0,bottom: 0.0,child: Text(
                                time,
                                maxLines: 1,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey),
                              ),)
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: _picItem(
                            listImg[0].toString(), itemWidth, itemHeight)),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
            ],
          )),);
    }
    if (listImg.length == 3) {
      return InkWell(onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(
                builder:(BuildContext context){
                  return NewsWeb(webUrl: webUrl,mTitle: itemTitle,);
                }));
//          Application.router.navigateTo(context, '${Routes.webPage}?url=${webUrl}');
      },child: Container(
        margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              itemTitle,
              maxLines: 2,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: _picItem(
                          listImg[0].toString(), itemWidth, itemHeight)),
                  Expanded(
                      child: _picItem(
                          listImg[1].toString(), itemWidth, itemHeight)),
                  Expanded(
                      child: _picItem(
                          listImg[2].toString(), itemWidth, itemHeight)),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                time,
                maxLines: 1,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            )
          ],
        ),
      ),);
    }
//    if (listImg.length == 2) {
//      return Container(
//        margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: <Widget>[
//            Text(
//              itemTitle,
//              maxLines: 2,
//              textAlign: TextAlign.left,
//              overflow: TextOverflow.ellipsis,
//              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//            ),
//            Row(
//              children: <Widget>[
//                Expanded(
//                    child:
//                        _picItem(listImg[0].toString(), itemWidth, itemHeight)),
//                Expanded(
//                    child:
//                        _picItem(listImg[1].toString(), itemWidth, itemHeight)),
//                Expanded(child: _picItem("", itemWidth, itemHeight)),
//              ],
//            ),
//            Text(
//              time,
//              maxLines: 1,
//              textAlign: TextAlign.left,
//              overflow: TextOverflow.ellipsis,
//              style: TextStyle(
//                  fontSize: 14,
//                  fontWeight: FontWeight.normal,
//                  color: Colors.grey),
//            ),
//          ],
//        ),
//      );
//    }

    return Container(
      width: 0.0,
      height: 0.0,
    );
  }

  Widget _picItem(String url, double itemWidth, double itemHeight) {
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: NovelCoverImage(
        url,
        width: itemWidth,
        height: itemHeight,
      ),
    );
  }
}
