import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StyleThemeData {
  static const green = Color.fromARGB(255, 114, 182, 108);
  static ThemeData themeData(BuildContext context) {
    return ThemeData(
      fontFamily: "Poppins",
      appBarTheme: AppBarTheme(
        centerTitle: false,
        color: green,
        titleTextStyle: TextStyle(
          fontSize: 20.sp,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Color.fromARGB(255, 170, 175, 181),
        showUnselectedLabels: false,
        enableFeedback: false,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll<Color>(green),
          foregroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
          textStyle: MaterialStatePropertyAll(
            TextStyle(
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
      outlinedButtonTheme: const OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll<Color>(
            green,
          ),
          side: MaterialStatePropertyAll<BorderSide>(
            BorderSide(color: green),
          ),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        textColor: Colors.black,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: green,
        ),
        titleMedium: TextStyle(
          color: green,
        ),
      ),
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
    );
  }
}
