import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/core/utils/app_asset.dart';

class PosterItemWidget extends StatelessWidget {
  const PosterItemWidget({
    super.key,
    required this.backDropPath,
    required this.posterPath,
    required this.starIcon,
    required this.movieTitle,
    required this.rating,
  });
  final String starIcon;
  final String backDropPath;
  final String posterPath;
  final String movieTitle;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                      imageUrl: AppAsset.imagePrefix + backDropPath,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                              color: Color(0xff92929D),
                            ),
                          ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
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
                        border: Border.all(color: Color(0x00000000)),
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
                              Color(0xffFF8700),
                              BlendMode.srcIn,
                            ),
                            semanticsLabel: 'Rating',
                          ),
                          Text(
                            rating.toStringAsFixed(1),
                            style: TextStyle(
                              color: Color(0xffFF8700),
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
                  imageUrl: AppAsset.imagePrefix + posterPath,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                        child: CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: Color(0xff92929D),
                        ),
                      ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  height: 120,
                  width: 95,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6, top: 60, right: 50),
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
    );
  }
}
