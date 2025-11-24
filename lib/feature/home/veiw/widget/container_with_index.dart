import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_color.dart';

class ContainerWithIndex extends StatelessWidget {
  const ContainerWithIndex({
    super.key,
    required this.pathImage,
    required this.index,
  });
  final String pathImage;
  final int index;
  static const double offsetAmount = 18.0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Image.asset(pathImage),
        Transform.translate(
          offset: const Offset(-offsetAmount, offsetAmount * 0.5),
          child: Text(
            index.toString(),
            style: TextStyle(
              fontSize: 96,
              fontWeight: FontWeight.w500,
              color: AppColor.backGroundColor,
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(-offsetAmount, offsetAmount * 0.5),
          child: Text(
            index.toString(),
            style: TextStyle(
              fontSize: 96,
              fontWeight: FontWeight.w500,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 2
                ..color = AppColor.selectedColor,
            ),
          ),
        ),
      ],
    );
  }
}
