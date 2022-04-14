import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wonder_widget/main.dart';
import 'package:flutter_wonder_widget/widget/button.dart';
import 'package:flutter_wonder_widget/widget/dial/red_pocket/red_packet.dart';

///领取红包 摘自
///https://juejin.cn/post/7075338022446694413
///https://github.com/loongwind/flutter_red_packet
class RedPocketPage extends StatelessWidget {
  const RedPocketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initScreenUtil(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(appString.redPocketPage),
        ),
        body: Center(
          child: Button(
            text: '点击领取',
            onPressed: () => showRedPacket(context, onOpen),
          ),
        ));
  }

  void initScreenUtil(BuildContext context) {
    ScreenUtil.init(
      context,
    );
  }

  void onOpen() {
    Navigator.push(
        currentContext,
        PageRouteBuilder(
            transitionDuration: const Duration(seconds: 1),
            pageBuilder: (context, animation, secondaryAnimation) =>
                FadeTransition(
                  opacity: animation,
                  child: const ResultPage(),
                )));
  }
}

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("红包领取结果"),
      ),
      body: Container(
        color: Colors.yellow,
        child: Center(
          child: Text(
            "恭喜您获得88888888元红包",
            style: TextStyle(color: Colors.redAccent, fontSize: 20.sp),
          ),
        ),
      ),
    );
  }
}
