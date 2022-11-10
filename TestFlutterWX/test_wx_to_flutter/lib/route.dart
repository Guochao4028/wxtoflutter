/// *
/// -  @Date: 2022-11-09 15:59
/// -  @LastEditTime: 2022-11-09 16:35
/// -  @Description:
///
import "package:flutter/material.dart";
import 'root_page.dart';

final routes = {
  "/": (context, {arguments}) => RootPage(
        arguments: arguments,
      ),
};

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404!'),
      ),
    );
  }
}

RouteFactory onGenerateRoute = (RouteSettings settings) {
  final String name = routeBeforeHook(settings);
  if (routes[name] != null) {
    final Function pageBuilder = routes[name]!;
    if (pageBuilder != null) {
      if (settings.arguments != null) {
        // 如果透传了参数
        return MaterialPageRoute(
          builder: (context) =>
              pageBuilder(context, arguments: settings.arguments),
          settings: settings,
        );
      } else {
        // 没有透传参数
        Map a = _dealAliPayUrlArguments(settings);
        return MaterialPageRoute(
          builder: (context) => pageBuilder(context, arguments: a),
          settings: settings,
        );
      }
    }
  }

  return MaterialPageRoute(builder: (context) => UnknownScreen());
};

String routeBeforeHook(RouteSettings settings) {
  String pathName = settings.name ?? "/";
  if (pathName.contains('/index?')) {
    pathName = "/";
  }
  return pathName;
}

String initialRoute() {
  return "/";
}

Map<String, dynamic> _dealAliPayUrlArguments(RouteSettings settings) {
  String pathName = settings.name ?? "/";
  Map<String, dynamic> argMap = Map<String, dynamic>();
  if (pathName.contains('?')) {
    List<String> strs = pathName.split("?");
    String argumentsStr = strs[1];
    List<String> argList = argumentsStr.split("&");

    for (String str in argList) {
      List<String> subStrs = str.split("=");
      argMap[subStrs[0]] = subStrs[1];
    }
  }
  argMap["temp"] = "1";
  return argMap;
}
