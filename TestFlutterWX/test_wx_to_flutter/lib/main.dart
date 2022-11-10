/// *
/// -  @Date: 2022-11-09 15:49
/// -  @LastEditTime: 2022-11-09 15:57
/// -  @Description:
///
import 'package:flutter/material.dart';
import 'package:test_wx_to_flutter/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TestWX',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: onGenerateRoute,
      initialRoute: initialRoute(),
    );
  }
}
