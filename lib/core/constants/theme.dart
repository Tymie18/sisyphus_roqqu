import 'package:flutter/material.dart';

const white = Colors.white;
const black = Colors.black;
const appBlack = Color(0xff17181B);
const rockBlack = Color(0xff1C2127);
const cardStroke = Color(0xff262932);
const textGreen = Color(0xff00C076);
const blackTint = Color(0xffA7B1BC);
const blackTint2 = Color(0xff737A91);
const blackTint3 = Color(0xff373B3F);
const divider = Color(0xffEAF0FE);

class CustomTheme {
  CustomTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'Satoshi',
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: appBlack,
      scaffoldBackgroundColor: const Color(0xffF8F8F9),
      iconTheme: const IconThemeData(
        color: appBlack,
      ),
      cardColor: white,
      shadowColor: const Color(0xffF1F1F1),
      appBarTheme: const AppBarTheme(
        backgroundColor: white,
        elevation: 0,
      ),
      tabBarTheme: TabBarTheme(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: white,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: blackTint2,
        labelColor: rockBlack,
      ),
      textTheme: const TextTheme().apply(
        bodyColor: appBlack,
        displayColor: appBlack,
      ),
      bottomSheetTheme:
          BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: 'Satoshi',
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: white,
      brightness: Brightness.dark,
      iconTheme: const IconThemeData(
        color: white,
      ),
      cardColor: appBlack,
      shadowColor: cardStroke,
      scaffoldBackgroundColor: rockBlack,
      appBarTheme: const AppBarTheme(
        backgroundColor: appBlack,
        elevation: 0,
      ),
      tabBarTheme: TabBarTheme(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: rockBlack,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: white,
        labelColor: white,
      ),
      textTheme: const TextTheme().apply(
        fontFamily: 'Satoshi',
        bodyColor: white,
        displayColor: white,
      ),
      bottomSheetTheme:
          BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
    );
  }
}
