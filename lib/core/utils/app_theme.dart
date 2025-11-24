import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData dark = ThemeData(
    scaffoldBackgroundColor: Color(0xff242A32),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xff242A32),
      centerTitle: true,
      iconTheme: IconThemeData(color: Color(0xffFFFFFF), size: 20),
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Color(0xffECECEC),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xff242A32),
      selectedLabelStyle: TextStyle(color: Color(0xff0296E5)),
      selectedItemColor: Color(0xff0296E5),
      unselectedLabelStyle: TextStyle(color: Color(0xff67686D)),
      unselectedItemColor: Color(0xff67686D),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Color(0xffFFFFFF),
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xffFFFFFF),
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xffEEEEEE),
      ),
      displayMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xff92929D),
      ),
    ),
    iconTheme: IconThemeData(color: Color(0xffEEEEEE)),
  );
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: Color(0xff242A32),
  );
}
