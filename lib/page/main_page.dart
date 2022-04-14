import 'package:flutter/material.dart';
import 'package:flutter_wonder_widget/main.dart';
import 'package:flutter_wonder_widget/manager/route_manager.dart';
import 'package:flutter_wonder_widget/model/widget_model.dart';
import 'package:flutter_wonder_widget/widget/list_item.dart';

///主页面TabPage
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<WidgetModel> _listWidget = [
    WidgetModel(
      title: appString.dialPage,
      routeName: RouteName.dialPage,
    ),
    WidgetModel(
      title: appString.redPocketPage,
      routeName: RouteName.redPocketPage,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appString.appName),
      ),
      body: ListView.builder(
        itemCount: _listWidget.length,
        itemBuilder: (context, index) => ListItem(
          title: Text(_listWidget[index].title),
          onTap: () =>
              Navigator.of(context).pushNamed(_listWidget[index].routeName),
        ),
      ),
    );
  }
}
