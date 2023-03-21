import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xyz_store/common/app_colors.dart';

class ThemeProvider with ChangeNotifier {
  bool _darkTheme = true;
  // bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  ThemeMode currentTheme() {
    return _darkTheme ? ThemeMode.dark : ThemeMode.light;
  }

  set darkTheme(bool value) {
    _darkTheme = value;
    notifyListeners();
  }
}

ThemeData appDarkTheme = ThemeData(
  primaryColor: const Color(0xFFFE3562),
  appBarTheme: AppBarTheme(
    backgroundColor: GlobalColors().primaryRed,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    unselectedItemColor: Colors.white70,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFFE3562),
  )),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: GlobalColors().primaryRed),
    ),
    filled: true,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  ),
  scaffoldBackgroundColor: Colors.black,
  textTheme: GoogleFonts.poppinsTextTheme()
      .apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      )
      .copyWith(titleLarge: const TextStyle(color: Colors.white)),
);

ThemeData appLightThme = ThemeData(
  primaryColor: const Color(0xFFFE3562),
  appBarTheme: AppBarTheme(
    backgroundColor: GlobalColors().primaryRed,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: GlobalColors().primaryRed,
      extendedTextStyle:
          const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFFE3562),
  )),
  inputDecorationTheme: const InputDecorationTheme(),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.black54,
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme: GoogleFonts.poppinsTextTheme()
      .apply(
        bodyColor: Colors.black,
        displayColor: Colors.black,
      )
      .copyWith(titleMedium: const TextStyle(fontWeight: FontWeight.w500)),
);
