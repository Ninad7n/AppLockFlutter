import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryColor = const Color(0xFFFFC107);
// Color secondaryColor = const Color(0xFF1F1F1F);
// Color backgroundDark = const Color(0xff0A0A0A);
Color secondaryColor = const Color(0xFF363944);
Color backgroundDark = const Color(0xff1B1C22);

const Color textPrimary = Color(0xff000000);
const Color textSecondary = Color(0xff838383);
Map<int, Color> color = const {
  50: Color.fromRGBO(255, 244, 149, .1),
  100: Color.fromRGBO(255, 244, 149, .2),
  200: Color.fromRGBO(255, 244, 149, .3),
  300: Color.fromRGBO(255, 244, 149, .4),
  400: Color.fromRGBO(255, 244, 149, .5),
  500: Color.fromRGBO(255, 244, 149, .6),
  600: Color.fromRGBO(255, 244, 149, .7),
  700: Color.fromRGBO(255, 244, 149, .8),
  800: Color.fromRGBO(255, 244, 149, .9),
  900: Color.fromRGBO(255, 244, 149, 1),
};
MaterialColor colorCustom = MaterialColor(0XFFFFF495, color);

class CustomTheme {
  static ThemeData dark = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: backgroundDark,
    hintColor: Colors.grey[200],
    canvasColor: secondaryColor,
    // primaryColorLight: secondaryColor,
    splashColor: secondaryColor,
    shadowColor: Colors.grey[600],
    cardColor: const Color(0xFFFFFFFF),
    primaryColor: primaryColor,
    dividerColor: const Color(0xFF2A2A2A),
    primaryColorDark: secondaryColor,

    // iconTheme: IconThemeData(color: Colors.grey[500]),
    // primaryIconTheme: IconThemeData(color: Colors.grey[500]),

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      actionsIconTheme: IconThemeData(
        color: primaryColor,
      ),
      iconTheme: IconThemeData(
        color: primaryColor,
      ),
    ),
    typography: Typography.material2021(),
    textTheme: TextTheme(
      button: GoogleFonts.montserrat(
        fontWeight: FontWeight.w400,
        color: textSecondary,
        fontSize: 14.0,
      ),

      // titleLarge: ,
      // titleMedium: ,
      // titleSmall: ,
      subtitle1: GoogleFonts.epilogue(
        // fontSize: 16.0,
        fontWeight: FontWeight.w400,
      ),
      bodyText1: GoogleFonts.epilogue(
        // fontSize: 14.0,
        fontWeight: FontWeight.w400,
      ),
      bodyText2: GoogleFonts.epilogue(
        // fontSize: 12.0,
        fontWeight: FontWeight.w500,
      ),

      headline1: GoogleFonts.epilogue(),
      headline2: GoogleFonts.epilogue(),
      headline3: GoogleFonts.epilogue(),
      headline4: GoogleFonts.epilogue(),
      headline5: GoogleFonts.epilogue(),
      headline6: GoogleFonts.epilogue(),
    ),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: colorCustom)
        .copyWith(background: backgroundDark)
        .copyWith(error: const Color(0xFFCF6679)),
  );
}
