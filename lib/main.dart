import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/common/application.dart';
import 'page/main_page.dart';

void main() {
  Application.globalInit(() {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WanAndroid-Flutter',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue,
      ),
      home: MainPage(),
    );
  }
}
