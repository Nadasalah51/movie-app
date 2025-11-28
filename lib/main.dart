import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_theme.dart';
import 'package:movie_app/feature/appsection/app_section_screen.dart';
import 'package:movie_app/feature/details/view/screen/details_screen.dart';
import 'package:movie_app/feature/home/view/screen/home_screen.dart';
import 'package:movie_app/feature/saved/view/screen/saved_screen.dart';
import 'package:movie_app/feature/search/view/screen/search_screen.dart';

void main() {
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        AppSectionScreen.routeName: (context) => AppSectionScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        SearchScreen.routeName: (context) => SearchScreen(),
        SavedScreen.routeName: (context) => SavedScreen(),
      },
      initialRoute: DetailsScreen.routeName,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
    );
  }
}
