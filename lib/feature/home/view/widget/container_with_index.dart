import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_asset.dart';
import 'package:movie_app/core/utils/app_color.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ContainerWithIndex extends StatelessWidget {
  const ContainerWithIndex({
    super.key,
    required this.pathImage,
    required this.index,
    this.onTap,
  });
  final String pathImage;
  final int index;
  final void Function()? onTap;
  static const double offsetAmount = 18.0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              progressIndicatorBuilder: (context, url, downloadProgress) =>
               Skeletonizer(
                enabled: true,
                child: SizedBox(
                  width: 144,
                  height: 210,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: AppColor.grayColor,
                    ),
                  ),
                ),
              ),
              errorWidget: (context, url, error) =>
                  Image.asset(AppAsset.dummyImage),
              imageUrl: pathImage,
              width: 144,
              height: 210,
            ),
          ),
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
      ),
    );
  }

}

