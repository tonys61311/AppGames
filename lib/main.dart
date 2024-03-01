import 'package:flutter/material.dart';
import 'package:games/page/HomePage.dart';
import 'package:games/widget/GameCardWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Games Collection',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//      ),
        theme: ThemeData(
          // 定義亮色主題
          brightness: Brightness.light,
          // 文本主題
          textTheme: TextTheme(
            // 默認文本樣式
            bodyText2: TextStyle(color: Colors.white),
          ),
          // 應用程序主要部分的背景色
          // scaffoldBackgroundColor: Colors.blue, // 背景色設定為藍色以便白色字體更易於觀察
        ),
      home: MyHomePage(title: 'Games Collection'),
    );
  }
}
