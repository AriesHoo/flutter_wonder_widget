import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///星标--常用于必填项
class StarMark extends StatelessWidget {
  const StarMark({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      CupertinoIcons.staroflife_fill,
      color: Colors.red,
      size: 12,
    );
  }
}
