import 'package:flutter/material.dart';
import 'package:flutter_wonder_widget/main.dart';
import 'package:flutter_wonder_widget/widget/dial/dial_clock.dart';

///自定义钟表
///摘自 https://juejin.cn/post/7072367482731757599
/// https://github.com/loongwind/flutter_dial
class DialPage extends StatelessWidget {
  const DialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appString.dialPage),
      ),
      body: const DialClock(),
    );
  }
}
