import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/core/utils/app_asset.dart';

class SavedScreen extends StatelessWidget {
  static const String routeName = 'SavedSceen';
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watch list'),
        leading: Center(
          child: SvgPicture.asset(AppAsset.menuIcon, width: 20, height: 20),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAsset.boxImage),
            Text(
              'There is no movie yet!',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              'Find your movie by Type title',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
      ),
    );
  }
}
