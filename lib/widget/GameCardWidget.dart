import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:games/models/game_type/index.dart';

class GameCardWidget extends StatelessWidget {
  final GameType gameType;
  final EdgeInsets padding;

  GameCardWidget({
    this.gameType,
    this.padding = const EdgeInsets.all(0)
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: AutoSizeText(
                      gameType.title,
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    maxLines: 1, // 限制为单行
                    minFontSize: 10, // 最小字体大小
                  ),
                )
            ),
            Expanded(
              flex: 7,
              child: Card(
                elevation: 50, // 提供浮出的視覺效果
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0), // 切圓角
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                        flex: 5,
                        child: Image.asset(gameType.imagePath)
                    ), // 遊戲圖示
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          Flexible(
                            flex: 5,
                            child: ElevatedButton(
                              onPressed: () {
                                // 按钮点击事件，根据 gameType 导航到相应的页面
                                Navigator.push(context, MaterialPageRoute(builder: (context) => gameType.buildPage));
                              },
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.teal.shade300, Colors.teal.shade700], // 从浅蓝绿到深蓝绿的渐变
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Container(
                                  // constraints: BoxConstraints(minWidth: Size.infinite.width, minHeight: Size.infinite.height), // 放大按钮尺寸
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'Start Game',
                                      style: TextStyle(fontSize: 50), // 这里的fontSize现在作为最大可能大小
                                    ),
                                  ),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.transparent, // 设为透明以显示渐变背景
                                shadowColor: Colors.teal.shade200, // 悬浮阴影颜色
                                elevation: 10, // 悬浮效果的高度
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                padding: EdgeInsets.zero, // 用于消除默认的内边距，确保渐变填充整个按钮
                              ),
                            )
                            ,
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Spacer()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}