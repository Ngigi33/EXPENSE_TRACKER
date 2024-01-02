import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 5, 59, 155));

var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark, seedColor: Color.fromARGB(255, 4, 11, 126));

void main() {
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kDarkColorScheme.primary,
          foregroundColor: kDarkColorScheme.primaryContainer,
          //centerTitle: true,
          elevation: 10.0,
          //shape:const Border.symmetric(horizontal: BorderSide(width: 10.0),vertical:BorderSide(width: 2) )
          //shadowColor: Colors.deepPurple
        ),
        cardTheme: const CardTheme().copyWith(
            color: kDarkColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.inversePrimary),
        ),
        textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
              fontWeight: FontWeight.w800,
              color: kColorScheme.inverseSurface,
              fontSize: 16,
            ))),
    theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
          centerTitle: true,
          elevation: 10.0,
          //shape:const Border.symmetric(horizontal: BorderSide(width: 10.0),vertical:BorderSide(width: 2) )
          //shadowColor: Colors.deepPurple
        ),
        cardTheme: const CardTheme().copyWith(
            color: kColorScheme.onInverseSurface,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.inversePrimary),
        ),
        textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
              fontWeight: FontWeight.w800,
              color: kColorScheme.inverseSurface,
              fontSize: 16,
            ))

        //scaffoldBackgroundColor: const Color.fromARGB(255, 136, 128, 245)
        ),
    themeMode: ThemeMode.system,
    home: const Expenses(),
  ));
}
