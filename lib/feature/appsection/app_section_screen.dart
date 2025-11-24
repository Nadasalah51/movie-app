import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/core/utils/app_asset.dart';
import 'package:movie_app/feature/home/veiw/screen/home_screen.dart';
import 'package:movie_app/feature/saved/veiw/screen/saved_screen.dart';
import 'package:movie_app/feature/search/veiw/screen/search_screen.dart';

class AppSectionScreen extends StatefulWidget {
  static const String routeName = 'AppSection';
  const AppSectionScreen({super.key});

  @override
  State<AppSectionScreen> createState() => _AppSectionScreenState();
}

class _AppSectionScreenState extends State<AppSectionScreen> {
  int _currentIndex = 0;
  final List<Widget> _screen = [HomeScreen(), SearchScreen(), SavedScreen()];
  Widget buildSvgIcon(String assetName) {
    return Builder(
      builder: (BuildContext context) {
        final Color? iconColor = IconTheme.of(context).color;

        return SvgPicture.asset(
          assetName,
          width: 24,
          height: 24,
          colorFilter: iconColor != null
              ? ColorFilter.mode(iconColor, BlendMode.srcIn)
              : null,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _currentIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: buildSvgIcon(AppAsset.homeIcon),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: buildSvgIcon(AppAsset.searchIcon),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: buildSvgIcon(AppAsset.savedIcon),
            label: 'Watch list',
          ),
        ],
      ),
    );
  }
}
