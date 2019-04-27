class CateItemBean{
  final String errmsg;
  final String errno;
  final Map<String,dynamic> data;// 为什么都强转了

  CateItemBean({this.errmsg, this.errno, this.data});

  factory CateItemBean.fromJson(Map<String, dynamic> json) {
    return CateItemBean(
      errmsg: json['errmsg'],
      errno: json['errno'],
      data: json['data'],
    );
  }

}