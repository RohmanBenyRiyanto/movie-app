import 'package:flutter/material.dart';

import '../../app/res/res.dart';
import 'themes.dart';

final ThemeData appTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: AppColor.primary,
    primaryContainer: AppColor.primaryLight,
    secondary: AppColor.secondary,
    secondaryContainer: AppColor.secondaryLight,
    background: AppColor.background,
    surface: AppColor.surface,
    onBackground: AppColor.textPrimary,
    onSurface: AppColor.textPrimary,
    onError: AppColor.error,
    error: AppColor.error,
    onPrimary: AppColor.textPrimary,
    onSecondary: AppColor.textPrimary,
  ),
  textTheme: const TextTheme(
    displayLarge: AppTextStyle.header1Light,
    displayMedium: AppTextStyle.header1Medium,
    displaySmall: AppTextStyle.header1Bold,
    headlineLarge: AppTextStyle.header1Light,
    headlineMedium: AppTextStyle.header1Medium,
    headlineSmall: AppTextStyle.header1Bold,
    titleLarge: AppTextStyle.label1Light,
    titleMedium: AppTextStyle.label1Medium,
    titleSmall: AppTextStyle.label1Bold,
    bodyLarge: AppTextStyle.label2Light,
    bodyMedium: AppTextStyle.label2Medium,
    bodySmall: AppTextStyle.label2Bold,
    labelLarge: AppTextStyle.label3Light,
    labelMedium: AppTextStyle.label3Medium,
    labelSmall: AppTextStyle.label3Bold,
  ),
  primaryColor: AppColor.primary,
  scaffoldBackgroundColor: AppColor.background,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColor.background,
    iconTheme: IconThemeData(color: AppColor.textPrimary),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: AppColor.accent,
    textTheme: ButtonTextTheme.primary,
  ),
  dividerColor: AppColor.divider,
  iconTheme: const IconThemeData(color: AppColor.textPrimary),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColor.primary,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: AppColor.surface,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColor.textPrimary,
    selectionColor: AppColor.accent.withOpacity(0.3),
    selectionHandleColor: AppColor.textPrimary,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColor.accent,
  ),
);
