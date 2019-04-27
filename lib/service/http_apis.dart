import "package:dio/dio.dart";
import 'dart:async';
import 'dart:io';
import 'package:flutter_news/congif/service_url.dart';

Future request(url,{formData})async{
  try{
    print('开始获取数据...............' + url);
    Response response;
    Dio dio = new Dio();
//    dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");
    if(formData==null){
      response = await dio.post(servicePath[url]);
    }else{
      response = await dio.post(servicePath[url],data:formData);
    }
    if(response.statusCode==200){
      return response.data;
    }else{
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  }catch(e){
    return print('ERROR:======>${e}');
  }

}

Future<List<Map>> requestList(url,{formData})async{
  try{
    print('开始获取数据...............' + url);
    Response response;
    Dio dio = new Dio();
//    dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");
    if(formData==null){
      response = await dio.post(servicePath[url]);
    }else{
      response = await dio.post(servicePath[url],data:formData);
    }
    print(response);
    if(response.statusCode==200){
      return (response.data['data'] as List ).cast();
    }else{
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  }catch(e){
    return null;
  }

}

Future requestOnly(url,{formData})async{
  try{
    print('开始获取数据...............' + url);
    Response response;
    Dio dio = new Dio();
//    dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");
    if(formData==null){
      response = await dio.post(url);
    }else{
      response = await dio.post(url,data:formData);
    }
    print(response);
    if(response.statusCode==200){
      return response.data;
    }else{
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  }catch(e){
    return print('ERROR:======>${e}');
  }

}