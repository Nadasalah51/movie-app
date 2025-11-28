import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/core/constants/app_const_api.dart';
import 'package:movie_app/core/utils/app_asset.dart';
import 'package:movie_app/core/utils/app_color.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PosterItemWidget extends StatelessWidget {
  const PosterItemWidget({
    super.key,
    this.backDropPath,
    this.posterPath,
    required this.starIcon,
    required this.movieTitle,
    required this.rating,
    required this.isLoading,
  });
  final String starIcon;
  final String? backDropPath;
  final String? posterPath;
  final String movieTitle;
  final double rating;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                                AppConstApi.imageBaseUrl + (backDropPath ?? ''),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                    value: downloadProgress.progress,
                                    color: AppColor.backGroundColor,
                                  ),
                                ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            height: 210,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Positioned(
                          bottom: 14,
                          right: 10,
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColor.transperantColor,
                              ),
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0x77252836),
                            ),

                            width: 54,
                            height: 24,
                            child: Row(
                              spacing: 4,
                              children: [
                                SvgPicture.asset(
                                  starIcon,
                                  colorFilter: const ColorFilter.mode(
                                    AppColor.orangeColor,
                                    BlendMode.srcIn,
                                  ),
                                  semanticsLabel: 'Rating',
                                ),
                                Text(
                                  rating.toStringAsFixed(1),
                                  style: TextStyle(
                                    color: AppColor.orangeColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 20,
                bottom: 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: AppConstApi.imageBaseUrl + (posterPath ?? ''),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                                color: AppColor.backGroundColor,
                              ),
                            ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        height: 120,
                        width: 95,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 6,
                        top: 60,
                        right: 50,
                      ),
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          movieTitle,
                          style: Theme.of(context).textTheme.bodyLarge,
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Skeletonizer(
            enabled: true,
            effect: ShimmerEffect(
              baseColor: AppColor.backGroundColor,
              highlightColor: AppColor.grayColor,
              duration: Duration(seconds: 1),
            ),

            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                            child: Image.asset(
                              AppAsset.dummyImage,
                              height: 210,
                              width: double.infinity,
                            ),
                          ),
                          Positioned(
                            bottom: 14,
                            right: 10,
                            child: Container(
                              padding: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColor.transperantColor,
                                ),
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0x77252836),
                              ),

                              width: 54,
                              height: 24,
                              child: Row(
                                spacing: 4,
                                children: [
                                  SvgPicture.asset(
                                    starIcon,
                                    colorFilter: const ColorFilter.mode(
                                      AppColor.orangeColor,
                                      BlendMode.srcIn,
                                    ),
                                    semanticsLabel: 'Rating',
                                  ),
                                  Text(
                                    rating.toStringAsFixed(1),
                                    style: TextStyle(
                                      color: AppColor.orangeColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 20,
                  bottom: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(AppAsset.dummyImage),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 6,
                          top: 60,
                          right: 50,
                        ),
                        child: SizedBox(
                          width: 200,
                          child: Text(
                            movieTitle,
                            style: Theme.of(context).textTheme.bodyLarge,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );

  }
}
