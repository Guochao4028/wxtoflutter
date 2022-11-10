/// *
/// -  @Date: 2022-11-09 16:01
/// -  @LastEditTime: 2022-11-09 16:01
/// -  @Description:
///
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'flutter_native_utils.dart';

class RootPage extends StatefulWidget {
  final Map? arguments;

  RootPage({this.arguments, Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  String text = "";
  String phone = "";
  static const _channel = MethodChannel("NATIVE_CHANNEL");
  @override
  void initState() {
    Map? a = widget.arguments;
    if (a != null) {
      text = a["accessToken"] ?? "";
      phone = a["phoneNumber"] ?? "";
    }

    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: GestureDetector(
          onTap: () {
            NativeJSUtlis.aliPayH5(phone);
          },
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}
