import 'package:flutter/material.dart';
import 'package:flutter1/ThemeProvider.dart';
import 'package:flutter1/Components/Pages.dart';

void main() {
  runApp(
      MyApp()
  );
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) =>
      ThemeBuilder(
         widgetBuilder : (context,theme) =>
            MaterialApp(
                title: "My First Flutter App",
                themeMode: theme,
                theme: ThemeData(
                  brightness: Brightness.light,
                ),
                darkTheme: ThemeData(
                  brightness: Brightness.dark,
                ),
                home: Homepage()
            )
      );
}




