
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_wonder_widget/widget/dial/dial_painter.dart';
///钟表
class DialClock extends StatefulWidget {
  const DialClock({Key? key}) : super(key: key);

  @override
  State<DialClock> createState() => _DialClockState();
}

class _DialClockState extends State<DialClock> {


  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: const Color.fromARGB(255, 35, 36, 38),
      child: Center(
        child: CustomPaint( // 使用CustomPaint
          size: Size(width, width),
          painter: DialPainter(),
        ),
      ),
    );
  }
}


