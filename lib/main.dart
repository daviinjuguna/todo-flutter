import 'package:flutter/material.dart';
import 'package:todo/page/todo_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(brightness: Brightness.dark),
        brightness: Brightness.light,
        colorScheme: ColorScheme.light(),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: const {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: TodoPage(),
    );
  }
}
