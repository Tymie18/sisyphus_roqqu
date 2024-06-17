import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sisyphus/core/core.dart';
import 'package:sisyphus/shared/widgets/text_style.dart';

import 'package:sisyphus/shared/widgets/widgets.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    required this.title,
    required this.onPressed,
    required this.color,
    this.height,
    this.width,
    super.key,
  });

  final String title;
  final VoidCallback onPressed;
  final Color color;

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        color: color,
        elevation: 0,
        padding: const EdgeInsets.all(8),
        onPressed: onPressed,
        child: SubText(
          text: title,
          foreground: white,
          textSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class DefaultGradientButton extends StatelessWidget {
  const DefaultGradientButton({
    required this.title,
    required this.onPressed,
    this.height,
    this.width,
    super.key,
  });

  final String title;
  final VoidCallback onPressed;

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        gradient: const LinearGradient(
          colors: [
            Color(0xff483BEB),
            Color(0xff7847E1),
            Color(0xffDD568D),
          ],
        ),
      ),
      child: MaterialButton(
        color: Colors.transparent,
        elevation: 0,
        padding: const EdgeInsets.all(8),
        onPressed: onPressed,
        child: SubText(
          text: title,
          foreground: white,
          textSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class DefaultImageButton extends StatelessWidget {
  const DefaultImageButton({
    required this.image,
    required this.onPressed,
    this.isSvg = false,
    this.size = 32,
    super.key,
  });

  final String image;
  final VoidCallback onPressed;
  final bool isSvg;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: InkWell(
        onTap: onPressed,
        child: isSvg
            ? SvgPicture.asset(
                image,
              )
            : Image.asset(
                image,
              ),
      ),
    );
  }
}
