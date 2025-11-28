import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/core/utils/app_asset.dart';
import 'package:movie_app/core/utils/app_color.dart';

class SearchItemModelWidget extends StatelessWidget {
  const SearchItemModelWidget({
    super.key,
    required this.pathImage,
    required this.vote,
    required this.ticket,
    required this.calender,
    required this.clock,
    required this.title,
  });
  final String pathImage;
  final double vote;
  final String ticket;
  final String calender;
  final String clock;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: CachedNetworkImage(
              imageUrl: pathImage == '' || pathImage == ' '
                  ? AppAsset.dummyImage
                  : '${AppAsset.imageBaseUrl}$pathImage',
              width: 95,
              height: 120,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Container(width: 95, height: 120, color: AppColor.grayColor),
              errorWidget: (context, url, error) => Image.asset(
                AppAsset.dummyImage,
                width: 95,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(height: 14),
                Row(
                  spacing: 4,
                  children: [
                    SvgPicture.asset(
                      AppAsset.starIcon,
                      color: AppColor.orangeColor,
                    ),
                    Text(
                      vote.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                Row(
                  spacing: 4,
                  children: [
                    SvgPicture.asset(AppAsset.ticketIcon),
                    Text(
                      ticket.toString(),
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                Row(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(AppAsset.calenderIcon),
                    Text(
                      calender.length >= 4
                          ? calender.substring(0, 4)
                          : calender,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    SvgPicture.asset(AppAsset.clockIcon),
                    Text(
                      calender.length >= 7
                          ? '${calender.substring(5, 7)} minutes'
                          : '$calender minutes',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
