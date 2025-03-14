import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.green,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
        headlineLarge: const TextStyle().copyWith(
            fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),
        headlineMedium: const TextStyle().copyWith(
            fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.black),
        headlineSmall: const TextStyle().copyWith(
            fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black),
        titleLarge: const TextStyle().copyWith(
            fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),
        titleMedium: const TextStyle().copyWith(
            fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black),
        titleSmall: const TextStyle().copyWith(
            fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black),
        bodyLarge: const TextStyle().copyWith(
            fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black),
        bodyMedium: const TextStyle().copyWith(
            fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black),
        bodySmall: const TextStyle().copyWith(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.black.withOpacity(0.5)),
        labelLarge: const TextStyle().copyWith(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.6)),
        labelMedium: const TextStyle().copyWith(
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
            color: Colors.black.withOpacity(0.3))),
    bottomSheetTheme: BottomSheetThemeData(
      showDragHandle: true,
      backgroundColor: Colors.white,
      modalBackgroundColor: Colors.white,
      constraints: const BoxConstraints(minWidth: double.infinity),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorMaxLines: 3,
      prefixIconColor: Colors.grey,
      suffixIconColor: Colors.grey,
      labelStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.black),
      hintStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.black),
      errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
      floatingLabelStyle: TextStyle(color: Colors.black.withOpacity(0.8)),
      border: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.grey,
          )),
      enabledBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.grey,
          )),
      focusedBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.grey,
          )),
      errorBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.grey,
          )),
      focusedErrorBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.grey,
          )),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.green,
        side: const BorderSide(color: Colors.green),
        textStyle: const TextStyle(
            fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        disabledBackgroundColor: Colors.grey,
        disabledForegroundColor: Colors.grey,
        side: const BorderSide(color: Colors.green),
        padding: const EdgeInsets.symmetric(vertical: 18),
        textStyle: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        } else {
          return Colors.black;
        }
      }),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.green;
        } else {
          return Colors.transparent;
        }
      }),
    )
  );
}
