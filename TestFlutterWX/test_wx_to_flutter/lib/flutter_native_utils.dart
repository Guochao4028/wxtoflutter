/// -  @Date: 2022-07-15 17:46
/// -  @LastEditTime: 2022-08-12 19:34
/// -  @Description: 处理Native通信
import 'dart:js' as js;

import 'package:flutter/services.dart';

class NativeUtlis {
  //channel_name每一个通信通道的唯一标识，在整个项目内唯一！！！
  static const _channel = MethodChannel("NATIVE_CHANNEL");

  /*
 * MethodChannel
 * 在方法通道上调用方法invokeMethod
 * methodName 方法名称
 * params 发送给原生的参数，自定义基本数据格式{"code":100,"message":"消息","content":内容}
 * return数据 原生发给Flutter的参数,自定义基本数据格式{"code":100,"message":"消息","content":内容}
 */
  static Future<Map> toolsMethodChannelMethodWithParams(String methodName,
      {Map<String, dynamic>? params}) async {
    var res = Map();
    try {
      res = await _channel.invokeMethod(methodName, params);
    } catch (e) {}
    return res;
  }
}

class NativeJSUtlis {
  static aliPayH5(String params) {
    //调用Js的方法
    js.context.callMethod("toWX", [params]);
  }
}
