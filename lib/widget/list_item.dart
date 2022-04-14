import 'package:flutter/material.dart';
import 'package:flutter_wonder_widget/widget/arrow.dart';
import 'package:flutter_wonder_widget/widget/star_mark.dart';

///[ListTile]复刻版本
class ListItem extends StatelessWidget {
  final bool starMark;
  final Widget? leading;
  final String? text;
  final Widget? title;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? spacePadding;
  final EdgeInsetsGeometry? margin;
  final double minHeight;
  final GestureTapCallback? onTap;
  final Widget? trailing;
  final AlignmentGeometry trailingAlignment;
  final Color? background;
  final bool? arrow;
  final Color? lineColor;
  final double? lineWidth;
  final bool lineTop;
  final bool lineBottom;
  final bool trailingExpanded;

  const ListItem({
    Key? key,
    this.starMark = false,
    this.leading,
    this.title,
    this.text,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.spacePadding = const EdgeInsets.only(left: 6),
    this.margin,
    this.minHeight = 44,
    this.onTap,
    this.trailing,
    this.trailingAlignment = Alignment.centerRight,
    this.background,
    this.arrow,
    this.lineColor,
    this.lineWidth = 1.0,
    this.lineTop = false,
    this.lineBottom = true,
    this.trailingExpanded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _arrow = arrow ?? onTap != null;
    Widget _leading = Padding(
      padding: leading != null && spacePadding != null
          ? spacePadding!
          : EdgeInsets.zero,
      child: title ??
          Text(
            text ?? '',
            style: Theme.of(context).textTheme.subtitle1,
          ),
    );
    Widget _trailing = Padding(
      padding: leading != null && spacePadding != null
          ? spacePadding!
          : EdgeInsets.zero,
      child: Align(
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.subtitle2!,
          child: trailing ?? const SizedBox(),
        ),
        alignment: trailingAlignment,
      ),
    );

    Widget _child = Row(
      children: [
        ///星标*必填项
        Visibility(
          visible: starMark,
          child: const StarMark(),
        ),

        ///星标*必填项
        Padding(
          padding: leading != null && spacePadding != null
              ? spacePadding!
              : EdgeInsets.zero,
          child: leading ?? const SizedBox(),
        ),
        trailingExpanded
            ? _leading
            : Expanded(
                child: _leading,
              ),
        trailingExpanded
            ? Expanded(
                child: _trailing,
              )
            : _trailing,

        Visibility(
          child: Padding(
            padding: spacePadding ?? EdgeInsets.zero,
            child: const Arrow(),
          ),
          visible: _arrow,
        ),
      ],
    );
    _child = Ink(
      decoration: BoxDecoration(
        border: lineBoxBorder(
          context,
          color: lineColor,
          width: lineWidth,
          top: lineTop,
          bottom: lineBottom,
        ),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: SafeArea(
          top: false,
          bottom: false,
          minimum:
              padding?.resolve(Directionality.of(context)) ?? EdgeInsets.zero,
          child: _child,
        ),
      ),
    );
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Material(
        color: background ?? Theme.of(context).cardColor,
        child: InkWell(
          child: _child,
          onTap: onTap,
          enableFeedback: true,
        ),
      ),
    );
  }

  ///添加边缘线
  BoxBorder lineBoxBorder(
    BuildContext context, {
    double? width,
    Color? color,
    bool left = false,
    bool top = false,
    bool right = false,
    bool bottom = false,
  }) {
    BorderSide side = BorderSide(
      width: width ?? 0.4,
      color: color ?? Theme.of(context).hintColor.withOpacity(0.05),
      style: BorderStyle.solid,
    );
    return Border(
      left: left ? side : BorderSide.none,
      top: top ? side : BorderSide.none,
      right: right ? side : BorderSide.none,
      bottom: bottom ? side : BorderSide.none,
    );
  }
}
