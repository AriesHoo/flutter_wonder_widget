import 'package:flutter/material.dart';

///右边箭头
class Arrow extends StatelessWidget {
  const Arrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.chevron_right_outlined,
      size: 20,
      color: Theme.of(context).textTheme.caption?.color,
    );
  }
}
