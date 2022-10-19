import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StyleThemeData {
  final colorGreen = const Color.fromARGB(255, 114, 182, 108);
  final textColor = const Color.fromARGB(255, 87, 87, 87);

  static const Green = Color.fromARGB(255, 114, 182, 108);
  static ThemeData themeData(BuildContext context) {
    return ThemeData(
      fontFamily: "Poppins",
      appBarTheme: AppBarTheme(
        centerTitle: false,
        color: Green,
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
          backgroundColor: const MaterialStatePropertyAll<Color>(Green),
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
            Green,
          ),
          side: MaterialStatePropertyAll<BorderSide>(
            BorderSide(color: Green),
          ),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        textColor: Colors.black,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Green,
        ),
        titleMedium: TextStyle(
          color: Green,
        ),
      ),
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
    );
  }
}
