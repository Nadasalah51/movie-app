import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/core/utils/app_asset.dart';

class DetailsScreen extends StatelessWidget {
  static const String routeName = 'DetailsScreen';
  const DetailsScreen({super.key});

  static const String imagePrefix = 'https://image.tmdb.org/t/p/w500';
  static List<int> similarList = List.generate(10, (index) => index + 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios, color: Color(0xffffffff), size: 26),
        title: Text(
          'Detail',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,

        actions: [
          Icon(Icons.bookmark_border, size: 26),
          // SvgPicture.asset(
          //   AppAsset.savedMovieIcon,
          //   colorFilter: const ColorFilter.mode(
          //     Color(0xffffffff),
          //     BlendMode.srcIn,
          //   ),
          //   semanticsLabel: 'Add To Watch List',
          // ),
          const SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            PosterItemWidget(
              backDropPath: imagePrefix + '/tQMlHruS4pU2PKLf9CgWwkFR399.jpg',
              posterPath: imagePrefix + '/flykCMw22y6yv8vKnBjmsW3pneo.jpg',
              starIcon: AppAsset.starIcon,
              movieTitle: 'Spiderman No Wy Homee',
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                InfoBarItemWidget(
                  icon: AppAsset.calenderIcon,
                  infoText: '2021',
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  width: 1.5,
                  height: 16,
                  color: Color(0xff696974),
                  child: Text(''),
                ),
                InfoBarItemWidget(
                  icon: AppAsset.clockIcon,
                  infoText: '148 Minutes',
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  width: 1.5,
                  height: 16,
                  color: Color(0xff696974),
                  child: Text(''),
                ),
                InfoBarItemWidget(
                  icon: AppAsset.ticketIcon,
                  infoText: 'Action',
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'similar',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),

            Wrap(
              children: similarList
                  .map(
                    (index) => ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 8),
                        child: CachedNetworkImage(
                          imageUrl:
                              imagePrefix + '/yqEj0oPfKBMCz7YcCARHDgH7VFm.jpg',
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                  value: downloadProgress.progress,
                                ),
                              ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          height: 145,
                          width: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoBarItemWidget extends StatelessWidget {
  const InfoBarItemWidget({
    super.key,
    required this.icon,
    required this.infoText,
  });

  final String icon;
  final String infoText;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        SvgPicture.asset(
          icon,
          colorFilter: const ColorFilter.mode(
            Color(0xff92929D),
            BlendMode.srcIn,
          ),
        ),
        Text(
          infoText,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Color(0xff92929D),
          ),
        ),
      ],
    );
  }
}

class PosterItemWidget extends StatelessWidget {
  const PosterItemWidget({
    super.key,
    required this.backDropPath,
    required this.posterPath,
    required this.starIcon,
    required this.movieTitle,
  });
  final String starIcon;
  final String backDropPath;
  final String posterPath;
  final String movieTitle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
                      imageUrl: backDropPath,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
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
                            '9.5',
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
              Padding(
                padding: const EdgeInsets.only(right: 60),
                child: SizedBox(
                  width: 160,
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
        Positioned(
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: posterPath,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                      ),
                    ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                height: 120,
                width: 95,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
