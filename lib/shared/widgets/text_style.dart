import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({
    required this.text,
    super.key,
    this.textSize = 20,
    this.foreground,
    this.letterSpacing = 0,
    this.fontWeight = FontWeight.w600,
    this.textAlign = TextAlign.left,
  });
  final String text;
  final double textSize;
  final Color? foreground;
  final double letterSpacing;
  final TextAlign textAlign;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: foreground ?? Theme.of(context).textTheme.titleMedium!.color!,
        fontSize: textSize,
        letterSpacing: letterSpacing,
        height: 1.1,
        fontWeight: fontWeight,
      ),
    );
  }
}

class SubText extends StatelessWidget {
  const SubText({
    required this.text,
    super.key,
    this.textSize = 15,
    this.foreground,
    this.decoration,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.fontStyle = FontStyle.normal,
    this.fontWeight = FontWeight.w500,
    this.shadows = const [],
    this.height,
  });
  final String text;
  final double textSize;
  final Color? foreground;
  final FontStyle fontStyle;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final List<Shadow> shadows;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        softWrap: softWrap,
        overflow: overflow,
        style: TextStyle(
          height: height,
          color: foreground ?? Theme.of(context).textTheme.titleMedium!.color!,
          overflow: overflow,
          fontSize: textSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          shadows: shadows,
          decoration: decoration,
        ),
      ),
    );
  }
}
