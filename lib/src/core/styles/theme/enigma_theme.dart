// import 'package:flutter/material.dart';
//
//
//
// final ThemeData customLightTheme = ThemeData(
//   // General Settings
//   brightness: Brightness.light,
//   useMaterial3: true,
//   visualDensity: VisualDensity.compact,
//   platform: TargetPlatform.macOS,
//   applyElevationOverlayColor: false,
//
//   // Colors
//   primaryColor: Colors.white,
//   primaryColorLight: const Color(0xffbbdefb),
//   primaryColorDark: const Color(0xff1976d2),
//   scaffoldBackgroundColor: Colors.white,
//   canvasColor: const Color(0xfff8f9ff),
//   cardColor: const Color(0xfff8f9ff),
//   dividerColor: const Color(0x1f191c20),
//   disabledColor: const Color(0x61000000),
//   focusColor: const Color(0x1f000000),
//   hoverColor: const Color(0x0a000000),
//   highlightColor: const Color(0x66bcbcbc),
//   splashColor: const Color(0x66c8c8c8),
//   splashFactory: InkRipple.splashFactory,
//   shadowColor: const Color(0xff000000),
//   unselectedWidgetColor: const Color(0x8a000000),
//
//   // Color Scheme
//   colorScheme: const ColorScheme(
//     brightness: Brightness.light,
//     primary: Colors.white,
//     onPrimary: Color(0xff001d36),
//     primaryContainer: Color(0xffd1e4ff),
//     onPrimaryContainer: Color(0xff001d36),
//     secondary: Color(0xff001d36),
//     onSecondary: Colors.white,
//     secondaryContainer: Color(0xffd7e3f7),
//     onSecondaryContainer: Color(0xff101c2b),
//     tertiary: Color(0xff6b5778),
//     onTertiary: Color(0xffffffff),
//     tertiaryContainer: Color(0xfff2daff),
//     onTertiaryContainer: Color(0xff251431),
//     error: Color(0xffba1a1a),
//     onError: Color(0xffffffff),
//     errorContainer: Color(0xffffdad6),
//     onErrorContainer: Color(0xff410002),
//     background: Color(0xfff8f9ff),
//     onBackground: Color(0xff191c20),
//     surface: Color(0xfff8f9ff),
//     onSurface: Color(0xff191c20),
//     surfaceVariant: Color(0xff43474e),
//     onSurfaceVariant: Color(0xff43474e),
//     outline: Color(0xff73777f),
//     outlineVariant: Color(0xffc3c7cf),
//     shadow: Color(0xff000000),
//     scrim: Color(0xff000000),
//     inversePrimary: Color(0xffa0cafd),
//     inverseSurface: Color(0xff2e3135),
//     surfaceTint: Color(0xff36618e),
//   ),
//
//   appBarTheme: const AppBarTheme(
//       backgroundColor: Color(0xff001d36), foregroundColor: Colors.white),
//
//   // Button Theme
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ElevatedButton.styleFrom(
//       backgroundColor: const Color(0xff36618e),
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(2.0),
//       ),
//       minimumSize: const Size(88, 36),
//     ),
//   ),
//   textButtonTheme: TextButtonThemeData(
//     style: TextButton.styleFrom(
//       foregroundColor: const Color(0xff36618e),
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(2.0),
//       ),
//     ),
//   ),
//   outlinedButtonTheme: OutlinedButtonThemeData(
//     style: OutlinedButton.styleFrom(
//       foregroundColor: const Color(0xffffffff),
//       //padding: const EdgeInsets.all(16),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(500.0),
//         // side: const BorderSide(
//         //   color: Color(0xff000000),
//         //   width: 50,
//         //   style: BorderStyle.none,
//         // ),
//       ),
//       minimumSize: const Size(88, 36),
//     ),
//   ),
//
//   // Icon Theme
//   iconTheme: const IconThemeData(
//     color: Color(0xdd000000),
//   ),
//
//   // Indicator Color
//   indicatorColor: const Color(0xffffffff),
//
//   // Text Themes
//   textTheme: _buildLightTextTheme(),
//   primaryTextTheme: _buildLightPrimaryTextTheme(),
//
//   // Input Decoration Theme
//   inputDecorationTheme: const InputDecorationTheme(
//     alignLabelWithHint: false,
//     filled: false,
//     floatingLabelAlignment: FloatingLabelAlignment.start,
//     floatingLabelBehavior: FloatingLabelBehavior.auto,
//     isCollapsed: false,
//     isDense: false,
//   ),
//
//   // Dialog Theme
//   dialogBackgroundColor: const Color(0xfff8f9ff),
//
//   // Divider Theme
//   dividerTheme: const DividerThemeData(
//     color: Color(0x1f191c20),
//     thickness: 1.0,
//   ),
//
//   bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//     backgroundColor: Colors.white, // Background color of the nav bar
//     selectedItemColor:
//         Color(0xff36618e), // Color of the selected icon and label
//     unselectedItemColor: Colors.grey, // Color of unselected items
//     selectedLabelStyle: TextStyle(
//         fontSize: 14,
//         fontFamily: "Circular Std"), // Font size of the selected label
//     unselectedLabelStyle: TextStyle(
//         fontSize: 12,
//         fontFamily: "Circular Std"), // Font size of the unselected label
//     type: BottomNavigationBarType
//         .fixed, // Set it to fixed to avoid shifting behavior
//   ),
// );
//
// // Dark Theme Data
// final ThemeData customDarkTheme = ThemeData(
//   // General Settings
//   brightness: Brightness.dark,
//   useMaterial3: true,
//   visualDensity: VisualDensity.compact,
//   platform: TargetPlatform.macOS,
//   applyElevationOverlayColor: true,
//
//   // Colors
//   primaryColor: const Color(0xff001d36),
//   primaryColorLight: const Color(0xff9e9e9e),
//   primaryColorDark: const Color(0xff000000),
//   scaffoldBackgroundColor: Color(0xff001d36),
//   canvasColor: const Color(0xff111418),
//   cardColor: const Color(0xff111418),
//   dividerColor: const Color(0x1fe1e2e8),
//   disabledColor: const Color(0x62ffffff),
//   focusColor: const Color(0xffffffff),
//   hoverColor: const Color(0x0affffff),
//   highlightColor: const Color(0x40cccccc),
//   splashColor: const Color(0x40cccccc),
//   splashFactory: InkRipple.splashFactory,
//   shadowColor: const Color(0xff000000),
//   unselectedWidgetColor: const Color(0xb3ffffff),
//
//   // Color Scheme
//   colorScheme: const ColorScheme(
//     brightness: Brightness.dark,
//     primary: Color(0xff001d36),
//     onPrimary: Colors.white,
//     primaryContainer: Color(0xff194975),
//     onPrimaryContainer: Color(0xffd1e4ff),
//     secondary: Colors.white,
//     onSecondary: Color(0xff001d36),
//     secondaryContainer: Color(0xff3b4858),
//     onSecondaryContainer: Color(0xffd7e3f7),
//     tertiary: Color(0xffd6bee4),
//     onTertiary: Color(0xff3b2948),
//     tertiaryContainer: Color(0xff523f5f),
//     onTertiaryContainer: Color(0xfff2daff),
//     error: Color(0xffffb4ab),
//     onError: Color(0xff690005),
//     errorContainer: Color(0xff93000a),
//     onErrorContainer: Color(0xffffdad6),
//     background: Color(0xff111418),
//     onBackground: Color(0xffe1e2e8),
//     surface: Color(0xff111418),
//     onSurface: Color(0xffe1e2e8),
//     surfaceVariant: Color(0xff43474e),
//     onSurfaceVariant: Color(0xffc3c7cf),
//     outline: Color(0xff8d9199),
//     outlineVariant: Color(0xff43474e),
//     shadow: Color(0xff000000),
//     scrim: Color(0xff000000),
//     inversePrimary: Color(0xff36618e),
//     inverseSurface: Color(0xffe1e2e8),
//     surfaceTint: Color(0xffa0cafd),
//   ),
//
//   bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//     backgroundColor: Color(0xff001d36), // Background color of the nav bar
//     selectedItemColor: Colors.white, // Color of the selected icon and label
//     unselectedItemColor: Colors.grey, // Color of unselected items
//     selectedLabelStyle: TextStyle(
//         fontSize: 14,
//         fontFamily: "Circular Std"), // Font size of the selected label
//     unselectedLabelStyle: TextStyle(
//         fontSize: 12,
//         fontFamily: "Circular Std"), // Font size of the unselected label
//     type: BottomNavigationBarType
//         .fixed, // Set it to fixed to avoid shifting behavior
//   ),
//
//   appBarTheme: const AppBarTheme(
//       toolbarHeight: 100,
//       backgroundColor: Colors.white,
//       foregroundColor: Color(0xff001d36)),
//
//   // Button Theme
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ElevatedButton.styleFrom(
//       backgroundColor: const Color(0xffa0cafd),
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(2.0),
//       ),
//       minimumSize: const Size(88, 36),
//     ),
//   ),
//   textButtonTheme: TextButtonThemeData(
//     style: TextButton.styleFrom(
//       foregroundColor: const Color(0xffa0cafd),
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(2.0),
//       ),
//     ),
//   ),
//   outlinedButtonTheme: OutlinedButtonThemeData(
//     style: OutlinedButton.styleFrom(
//       foregroundColor: const Color(0xff001d36),
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(500),
//         side: const BorderSide(
//           color: Color(0xff000000),
//           width: 5,
//           style: BorderStyle.none,
//         ),
//       ),
//       minimumSize: const Size(88, 36),
//     ),
//   ),
//
//   // Icon Theme
//   iconTheme: const IconThemeData(
//     color: Color(0xffffffff),
//   ),
//
//   // Indicator Color
//   indicatorColor: const Color(0xffe1e2e8),
//
//   // Text Themes
//   textTheme: _buildDarkTextTheme(),
//   primaryTextTheme: _buildDarkPrimaryTextTheme(),
//
//   // Input Decoration Theme
//   inputDecorationTheme: const InputDecorationTheme(
//     alignLabelWithHint: false,
//     filled: false,
//     floatingLabelAlignment: FloatingLabelAlignment.start,
//     floatingLabelBehavior: FloatingLabelBehavior.auto,
//     isCollapsed: false,
//     isDense: false,
//   ),
//
//   // Dialog Theme
//   dialogBackgroundColor: const Color(0xff111418),
//
//   // Divider Theme
//   dividerTheme: const DividerThemeData(
//     color: Color(0x1fe1e2e8),
//     thickness: 1.0,
//   ),
// );
//
// // Light Text Theme Builder
// TextTheme _buildLightTextTheme() {
//   return TextTheme(
//     bodyLarge: _buildTextStyle(
//       color: const Color(0xff191c20),
//       fontSize: 16,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.5,
//       fontFamily: 'Circular Std',
//       height: 1.5,
//     ),
//     bodyMedium: _buildTextStyle(
//       color: const Color(0xff191c20),
//       fontSize: 14,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.25,
//       fontFamily: 'Circular Std',
//       height: 1.43,
//     ),
//     bodySmall: _buildTextStyle(
//       color: const Color(0xff191c20),
//       fontSize: 12,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.4,
//       fontFamily: 'Circular Std',
//       height: 1.33,
//     ),
//     displayLarge: _buildTextStyle(
//       color: const Color(0xff191c20),
//       fontSize: 96,
//       fontWeight: FontWeight.w300,
//       letterSpacing: -1.5,
//       fontFamily: 'Circular Std',
//       height: 1.12,
//     ),
//     displayMedium: _buildTextStyle(
//       color: const Color(0xff191c20),
//       fontSize: 60,
//       fontWeight: FontWeight.w300,
//       letterSpacing: -0.5,
//       fontFamily: 'Circular Std',
//       height: 1.16,
//     ),
//     displaySmall: _buildTextStyle(
//       color: const Color(0xff191c20),
//       fontSize: 48,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0,
//       fontFamily: 'Circular Std',
//       height: 1.22,
//     ),
//     headlineLarge: _buildTextStyle(
//       color: const Color(0xff191c20),
//       fontSize: 40,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.25,
//       fontFamily: 'Circular Std',
//       height: 1.25,
//     ),
//     headlineMedium: _buildTextStyle(
//       color: const Color(0xff191c20),
//       fontSize: 34,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.25,
//       fontFamily: 'Circular Std',
//       height: 1.29,
//     ),
//     headlineSmall: _buildTextStyle(
//       color: const Color(0xff191c20),
//       fontSize: 24,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0,
//       fontFamily: 'Circular Std',
//       height: 1.33,
//     ),
//     labelLarge: _buildTextStyle(
//       color: const Color(0xff191c20),
//       fontSize: 14,
//       fontWeight: FontWeight.w500,
//       letterSpacing: 1.25,
//       fontFamily: 'Circular Std',
//       height: 1.43,
//     ),
//     labelMedium: _buildTextStyle(
//       color: const Color(0xff191c20),
//       fontSize: 11,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 1.5,
//       fontFamily: 'Circular Std',
//       height: 1.33,
//     ),
//     labelSmall: _buildTextStyle(
//       color: const Color(0xff191c20),
//       fontSize: 10,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.75,
//       fontFamily: 'Circular Std',
//       height: 1.45,
//     ),
//     titleLarge: _buildTextStyle(
//       color: const Color(0xff191c20),
//       fontSize: 20,
//       fontWeight: FontWeight.w500,
//       letterSpacing: 0.15,
//       fontFamily: 'Circular Std',
//       height: 1.27,
//     ),
//     titleMedium: _buildTextStyle(
//       color: const Color(0xff191c20),
//       fontSize: 16,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.15,
//       fontFamily: 'Circular Std',
//       height: 1.5,
//     ),
//     titleSmall: _buildTextStyle(
//       color: const Color(0xff191c20),
//       fontSize: 14,
//       fontWeight: FontWeight.w500,
//       letterSpacing: 0.1,
//       fontFamily: 'Circular Std',
//       height: 1.43,
//     ),
//   );
// }
//
// // Light Primary Text Theme Builder
// TextTheme _buildLightPrimaryTextTheme() {
//   return TextTheme(
//     bodyLarge: _buildTextStyle(
//       color: const Color(0xfff8f9ff),
//       fontSize: 16,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.5,
//       fontFamily: 'Circular Std',
//       height: 1.5,
//     ),
//     bodyMedium: _buildTextStyle(
//       color: const Color(0xfff8f9ff),
//       fontSize: 14,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.25,
//       fontFamily: 'Circular Std',
//       height: 1.43,
//     ),
//     bodySmall: _buildTextStyle(
//       color: const Color(0xfff8f9ff),
//       fontSize: 12,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.4,
//       fontFamily: 'Circular Std',
//       height: 1.33,
//     ),
//     displayLarge: _buildTextStyle(
//       color: const Color(0xfff8f9ff),
//       fontSize: 96,
//       fontWeight: FontWeight.w300,
//       letterSpacing: -1.5,
//       fontFamily: 'Circular Std',
//       height: 1.12,
//     ),
//     displayMedium: _buildTextStyle(
//       color: const Color(0xfff8f9ff),
//       fontSize: 60,
//       fontWeight: FontWeight.w300,
//       letterSpacing: -0.5,
//       fontFamily: 'Circular Std',
//       height: 1.16,
//     ),
//     displaySmall: _buildTextStyle(
//       color: const Color(0xfff8f9ff),
//       fontSize: 48,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0,
//       fontFamily: 'Circular Std',
//       height: 1.22,
//     ),
//     headlineLarge: _buildTextStyle(
//       color: const Color(0xfff8f9ff),
//       fontSize: 40,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.25,
//       fontFamily: 'Circular Std',
//       height: 1.25,
//     ),
//     headlineMedium: _buildTextStyle(
//       color: const Color(0xfff8f9ff),
//       fontSize: 34,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.25,
//       fontFamily: 'Circular Std',
//       height: 1.29,
//     ),
//     headlineSmall: _buildTextStyle(
//       color: const Color(0xfff8f9ff),
//       fontSize: 24,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0,
//       fontFamily: 'Circular Std',
//       height: 1.33,
//     ),
//     labelLarge: _buildTextStyle(
//       color: const Color(0xfff8f9ff),
//       fontSize: 14,
//       fontWeight: FontWeight.w500,
//       letterSpacing: 1.25,
//       fontFamily: 'Circular Std',
//       height: 1.43,
//     ),
//     labelMedium: _buildTextStyle(
//       color: const Color(0xfff8f9ff),
//       fontSize: 11,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 1.5,
//       fontFamily: 'Circular Std',
//       height: 1.33,
//     ),
//     labelSmall: _buildTextStyle(
//       color: const Color(0xfff8f9ff),
//       fontSize: 10,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.75,
//       fontFamily: 'Circular Std',
//       height: 1.45,
//     ),
//     titleLarge: _buildTextStyle(
//       color: const Color(0xfff8f9ff),
//       fontSize: 20,
//       fontWeight: FontWeight.w500,
//       letterSpacing: 0.15,
//       fontFamily: 'Circular Std',
//       height: 1.27,
//     ),
//     titleMedium: _buildTextStyle(
//       color: const Color(0xfff8f9ff),
//       fontSize: 16,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.15,
//       fontFamily: 'Circular Std',
//       height: 1.5,
//     ),
//     titleSmall: _buildTextStyle(
//       color: const Color(0xfff8f9ff),
//       fontSize: 14,
//       fontWeight: FontWeight.w500,
//       letterSpacing: 0.1,
//       fontFamily: 'Circular Std',
//       height: 1.43,
//     ),
//   );
// }
//
// // Dark Text Theme Builder
// TextTheme _buildDarkTextTheme() {
//   return TextTheme(
//     bodyLarge: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 16,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.5,
//       fontFamily: 'Circular Std',
//       height: 1.5,
//     ),
//     bodyMedium: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 14,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.25,
//       fontFamily: 'Circular Std',
//       height: 1.43,
//     ),
//     bodySmall: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 12,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.4,
//       fontFamily: 'Circular Std',
//       height: 1.33,
//     ),
//     displayLarge: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 96,
//       fontWeight: FontWeight.w300,
//       letterSpacing: -1.5,
//       fontFamily: 'Circular Std',
//       height: 1.12,
//     ),
//     displayMedium: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 60,
//       fontWeight: FontWeight.w300,
//       letterSpacing: -0.5,
//       fontFamily: 'Circular Std',
//       height: 1.16,
//     ),
//     displaySmall: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 48,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0,
//       fontFamily: 'Circular Std',
//       height: 1.22,
//     ),
//     headlineLarge: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 40,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.25,
//       fontFamily: 'Circular Std',
//       height: 1.25,
//     ),
//     headlineMedium: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 34,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.25,
//       fontFamily: 'Circular Std',
//       height: 1.29,
//     ),
//     headlineSmall: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 24,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0,
//       fontFamily: 'Circular Std',
//       height: 1.33,
//     ),
//     labelLarge: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 14,
//       fontWeight: FontWeight.w500,
//       letterSpacing: 1.25,
//       fontFamily: 'Circular Std',
//       height: 1.43,
//     ),
//     labelMedium: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 11,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 1.5,
//       fontFamily: 'Circular Std',
//       height: 1.33,
//     ),
//     labelSmall: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 10,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 1.5,
//       fontFamily: 'Circular Std',
//       height: 1.45,
//     ),
//     titleLarge: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 20,
//       fontWeight: FontWeight.w500,
//       letterSpacing: 0.15,
//       fontFamily: 'Circular Std',
//       height: 1.27,
//     ),
//     titleMedium: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 16,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.15,
//       fontFamily: 'Circular Std',
//       height: 1.5,
//     ),
//     titleSmall: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 14,
//       fontWeight: FontWeight.w500,
//       letterSpacing: 0.1,
//       fontFamily: 'Circular Std',
//       height: 1.43,
//     ),
//   );
// }
//
// // Dark Primary Text Theme Builder
// TextTheme _buildDarkPrimaryTextTheme() {
//   return TextTheme(
//     bodyLarge: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 16,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.5,
//       fontFamily: 'Circular Std',
//       height: 1.5,
//     ),
//     bodyMedium: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 14,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.25,
//       fontFamily: 'Circular Std',
//       height: 1.43,
//     ),
//     bodySmall: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 12,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.4,
//       fontFamily: 'Circular Std',
//       height: 1.33,
//     ),
//     displayLarge: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 96,
//       fontWeight: FontWeight.w300,
//       letterSpacing: -1.5,
//       fontFamily: 'Circular Std',
//       height: 1.12,
//     ),
//     displayMedium: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 60,
//       fontWeight: FontWeight.w300,
//       letterSpacing: -0.5,
//       fontFamily: 'Circular Std',
//       height: 1.16,
//     ),
//     displaySmall: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 48,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0,
//       fontFamily: 'Circular Std',
//       height: 1.22,
//     ),
//     headlineLarge: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 40,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.25,
//       fontFamily: 'Circular Std',
//       height: 1.25,
//     ),
//     headlineMedium: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 34,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.25,
//       fontFamily: 'Circular Std',
//       height: 1.29,
//     ),
//     headlineSmall: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 24,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0,
//       fontFamily: 'Circular Std',
//       height: 1.33,
//     ),
//     labelLarge: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 14,
//       fontWeight: FontWeight.w500,
//       letterSpacing: 1.25,
//       fontFamily: 'Circular Std',
//       height: 1.43,
//     ),
//     labelMedium: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 11,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 1.5,
//       fontFamily: 'Circular Std',
//       height: 1.33,
//     ),
//     labelSmall: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 10,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 1.5,
//       fontFamily: 'Caros',
//       height: 1.45,
//     ),
//     titleLarge: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 20,
//       fontWeight: FontWeight.w500,
//       letterSpacing: 0.15,
//       fontFamily: 'Circular Std',
//       height: 1.27,
//     ),
//     titleMedium: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 16,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.15,
//       fontFamily: 'Circular Std',
//       height: 1.5,
//     ),
//     titleSmall: _buildTextStyle(
//       color: const Color(0xffe1e2e8),
//       fontSize: 14,
//       fontWeight: FontWeight.w500,
//       letterSpacing: 0.1,
//       fontFamily: 'Circular Std',
//       height: 1.43,
//     ),
//   );
// }
//
// // Helper function to create TextStyle
// TextStyle _buildTextStyle({
//   required Color color,
//   required double fontSize,
//   required FontWeight fontWeight,
//   double? letterSpacing,
//   String? fontFamily,
//   double? height,
// }) {
//   return TextStyle(
//     color: color,
//     fontSize: fontSize,
//     fontWeight: fontWeight,
//     letterSpacing: letterSpacing,
//     fontFamily: fontFamily,
//     height: height,
//     decoration: TextDecoration.none,
//     decorationColor: color,
//   );
// }
