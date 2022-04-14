import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wonder_widget/page/dial_page.dart';
import 'package:flutter_wonder_widget/page/main_page.dart';
import 'package:flutter_wonder_widget/page/red_pocket_page.dart';

///
class RouteName {
  ///主页面
  static const String mainPage = 'mainPage';

  ///钟表
  static const String dialPage = 'dialPage';

  ///微信领取红包
  static const String redPocketPage = 'redPocketPage';
}

///用于main MaterialApp配置 onGenerateRoute
class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.mainPage:
        return CupertinoPageRoute(
          settings: settings,
          builder: (context) => const MainPage(),
        );
      case RouteName.dialPage:
        return CupertinoPageRoute(
          settings: settings,
          builder: (context) => const DialPage(),
        );
      case RouteName.redPocketPage:
        return CupertinoPageRoute(
          settings: settings,
          builder: (context) => const RedPocketPage(),
        );
      default:
        return CupertinoPageRoute(
            settings: RouteSettings(name: settings.name),
            builder: (context) => Scaffold(
                  body: Center(
                    child: Text(
                      'No route defined for ${settings.name}',
                      textScaleFactor: 1,
                    ),
                  ),
                ));
    }
  }
}
