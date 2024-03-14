import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:games/model/MJModel.dart';

class Mahjong extends StatefulWidget {
  final double width;
  final double height;
  final bool back;
  final bool side;
  final MJModel model;
  final EdgeInsetsGeometry margin;
  final bool hasDel;
  final GestureTapCallback onDel;

  const Mahjong({
    Key key,
    this.width,
    this.height,
    this.back = true,
    this.side = false,
    this.model,
    this.margin,
    this.hasDel = false,
    this.onDel,
  })
      : super(key: key);
  @override
  _MahjongState createState() => _MahjongState();
}

class _MahjongState extends State<Mahjong> {
  @override
  Widget build(BuildContext context) {
    String filePath;
    if(!widget.back){
      if(widget.model.type.isNotText){
        filePath = 'assets/img/${widget.model.type.getText}_${widget.model.num}.png';
      }else{
        filePath = 'assets/img/${widget.model.type.getText}.png';
      }
    }

    return AnimatedContainer(
        curve:Curves.bounceIn,
        duration: Duration(milliseconds: 2400),
        margin: EdgeInsets.all(3),
        child: widget.side ? Transform(
            transform: new Matrix4.skewY(-0.2),
            child: Container(
                width: widget.width,
                child: Transform(
                  transform: new Matrix4.skewY(0.3),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: widget.height*1.22,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)
                            )
                        ),
                      ),
                      Container(
                        width: 10,
                        height: widget.height*1.22,
                        decoration: BoxDecoration(
                            color: Colors.orange[800],
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10)
                            )
                        ),
                      )
                    ],
                  ),
                )
            )
        ) : Container(
          margin: widget.margin,
          child: Stack(
            children: [
              Container(
                width: widget.width,
                height: widget.back ? widget.height*1.23 : widget.height*1.22,
                decoration: widget.back ? BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20)
                ) : BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20)
                ),
                //child: Text('www'),
              ),
              Container(
                width: widget.width,
                height:widget.back ? widget.height*1.11 : widget.height*1.13,
                decoration: widget.back ? BoxDecoration(
                    color: Colors.orange[800],
                    borderRadius: BorderRadius.circular(20)
                ) : BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
              Container(
                width: widget.width,
                height: widget.height,
                decoration: widget.back ? BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20)
                ) : BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.grey[200],Colors.white60],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(20)
                ),
                child: widget.back ? Container() : Image.asset(filePath),
                //child: Text('www'),
              ),
              Positioned(
                  top:0,
                  right:0,
                  child: Visibility(
                    visible: widget.hasDel,
                    child: InkWell(
                      onTap: widget.onDel,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),),
                  ))
            ],
          ),
        )
    );
  }
}

class MJView extends StatefulWidget {
  final bool back; // 是否顯示牌的背面
  final bool side; // 是否顯示牌的側面視圖
  final MJModel model; // 麻將牌模型，包含牌的信息
  final EdgeInsetsGeometry margin; // 麻將牌外邊距
  final bool hasDel; // 是否顯示刪除按鈕
  final GestureTapCallback onDel; // 點擊刪除按鈕的回調函數

  const MJView({
    Key key,
    this.back = true,
    this.side = false,
    this.model,
    this.margin,
    this.hasDel = false,
    this.onDel,
  })
      : super(key: key);
  @override
  _MJViewState createState() => _MJViewState();
}

class _MJViewState extends State<MJView> {
  @override
  Widget build(BuildContext context) {
    String filePath;
    if(!widget.back){
      if(widget.model.type.isNotText){
        filePath = 'assets/img/${widget.model.type.getText}_${widget.model.num}.png';
      }else{
        filePath = 'assets/img/${widget.model.type.getText}.png';
      }
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // 在這裡，您可以使用constraints來獲取寬度和高度
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        // 使用獲取到的寬高來構建您的Widget
        return AnimatedContainer(
            curve:Curves.bounceIn,
            duration: Duration(milliseconds: 2400),
            margin: EdgeInsets.all(3),
            child: widget.side ? buildSideView(width) : buildCardView(width, filePath)
        ); // 根據寬高構建Container
      },
    );
  }

  Container buildCardView(double width, String filePath) {
    double cardHeight = width * 1.4;
    return Container(
            margin: widget.margin,
            child: Stack(
              children: [
                // 底層容器，用於顯示牌的背面或正面的底色
                Container(
                  width: width,
                  height: cardHeight,
                  decoration: BoxDecoration(
                      color: widget.back ? Colors.grey[300] : Colors.orange, // 背面顏色
                      borderRadius: BorderRadius.circular(20) // 圓角設定
                  ),
                ),
                // 第二層容器，用於創建有色邊框效果
                Container(
                    width: width,
                    height: cardHeight*0.87,
                    decoration: BoxDecoration(
                        color: widget.back ? Colors.orange[800] : Colors.grey[300], // 背面邊框顏色
                        borderRadius: BorderRadius.circular(20) // 圓角設定
                    )
                ),
                // 第三層容器，用於顯示牌的正面圖案或保持空白
                Container(
                  width: width,
                  height: cardHeight*0.76,
                  decoration: widget.back ? BoxDecoration(
                      color: Colors.orange, // 背面顏色
                      borderRadius: BorderRadius.circular(20) // 圓角設定
                  ) : BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.grey[200], Colors.white60], // 正面漸變色
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(20) // 圓角設定
                  ),
                  child: widget.back ? Container() : Image.asset(filePath), // 若為正面，顯示圖片
                ),
                // 刪除按鈕，點擊後觸發 onDel 回調
                Positioned(
                    top:0,
                    right:0,
                    child: Visibility(
                      visible: widget.hasDel, // 根據 hasDel 決定是否顯示
                      child: InkWell(
                        onTap: widget.onDel, // 點擊觸發的回調函數
                        child: Container(
                          padding: EdgeInsets.all(2), // 內邊距
                          decoration: BoxDecoration(
                            color: Colors.grey, // 背景顏色
                            borderRadius: BorderRadius.circular(50), // 圓形邊框
                          ),
                          child: Icon(
                            Icons.close, // 關閉圖標
                            color: Colors.white, // 圖標顏色
                            size: 26, // 圖標大小
                          ),
                        ),
                      ),
                    )
                )
              ],
            ),
          );
  }

  Widget buildSideView(double width) {
    return Transform(
        transform: new Matrix4.skewY(-0.3),
        child: Transform(
          transform: new Matrix4.skewY(0.3),
          child: Row(
            children: [
              Container(
                width: width*0.2,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)
                    )
                ),
              ),
              Container(
                width: width*0.1,
                decoration: BoxDecoration(
                    color: Colors.orange[800],
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    )
                ),
              )
            ],
          ),
        )
    );

  }
}





class AppDialog extends StatefulWidget {
  final String title; //彈窗標題
  final double reduceWidth; //彈窗寬，須減少多少，預設80
  final double width; //彈窗寬，必須設定
  final double height; //彈窗高，必須設定
  final List<Widget> actionButtons; //動作按鈕
  final Widget child; //彈窗內容
  final bool closeIcon; //是否顯示關閉按鈕
  final AlignmentGeometry contentAlignment; //內容Container對齊方式，預設centerLeft
  final bool scrollable;

  final double paddingTop; //padding 上
  final double paddingBottom; //padding 下
  final double paddingLeft; //padding 左
  final double paddingRight; //padding 右
  final Function onClose; //彈窗關閉鈕

  const AppDialog({
    Key key,
    this.title,
    this.width,
    this.height,
    this.actionButtons,
    this.child,
    this.closeIcon = true,
    this.contentAlignment = Alignment.centerLeft,
    this.scrollable = false,
    this.reduceWidth = 80,
    this.paddingTop = 10,
    this.paddingBottom = 20,
    this.paddingLeft = 20,
    this.paddingRight = 20,
    this.onClose,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return AppDialogState();
  }
}

class AppDialogState extends State<AppDialog> {
  @override
  Widget build(BuildContext context) {
// TODO: implement build
    var titleHeight = 50.0;

    return AlertDialog(
      actionsOverflowButtonSpacing: 0,
      scrollable: widget.scrollable,
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      elevation: 0,
      content: Container(
        width: (this.widget.width - widget.reduceWidth),
        height: this.widget.height,
        decoration: BoxDecoration(
          color: Colors.white,
          //borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Color(0x7f000000),
                offset: Offset(0, 2),
                blurRadius: 2,
                spreadRadius: 0)
          ],
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
                right: 4,
                child: Visibility(
                  visible: this.widget.closeIcon,
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon(
                      Icons.highlight_off,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: widget.onClose != null ? widget.onClose : () {
                      Navigator.of(context).pop();
                    },
                  ),
                )),
            Positioned(
              bottom: 40,
              child: this.widget.actionButtons != null
                  ? Container(
                width: this.widget.width - widget.reduceWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: this.widget.actionButtons,
                ),
              )
                  : SizedBox(),
            ),
            Container(
              alignment: this.widget.contentAlignment,
              padding: EdgeInsets.only(
                  top: titleHeight + widget.paddingTop,
                  left: widget.paddingLeft,
                  right: widget.paddingRight,
                  bottom: this.widget.actionButtons != null ? 90 : widget.paddingBottom),
              child: this.widget.child,
            ),
          ],
        ),
      ),
    );
  }
}


void showAppDialog(BuildContext context, Widget dialog,
    {bool barrierDismissible = false}) {
  showDialog(
      barrierDismissible: barrierDismissible, //点击遮罩不关闭对话框
      context: context,
      builder: (context) {
        return dialog;
      });
}


//按鈕-----------
class PrimaryButton extends StatefulWidget {
  final String label; //按鈕文字
  final VoidCallback onPressed; //按鈕動作
  final EdgeInsetsGeometry margin; //按鈕外間距
  final Color color; //按鈕顏色
  final EdgeInsetsGeometry padding; //按鈕內間距

  const PrimaryButton(
      {Key key,
        this.label,
        this.onPressed,
        this.margin,
        this.color,
        this.padding =
        const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8)})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return PrimaryButtonState();
  }
}

class PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return Container(
      margin: this.widget.margin,
      child: ButtonTheme(
        minWidth: 160,
        child: ElevatedButton(
          child: Text(this.widget.label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                letterSpacing: 0,
              )),
          onPressed: this.widget.onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(this.widget.color),
            padding: MaterialStateProperty.all(this.widget.padding),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)))),
          )
          // textColor: Color(0xffffffff),
          // padding: widget.padding,
          // color: this.widget.color,
          // highlightColor: Colors.transparent,
          // splashColor: Colors.transparent,
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
      ),
    );
  }
}




//立體按鈕-----------
class Button3D extends StatefulWidget {
  final String label; //按鈕文字


  const Button3D(
      {Key key,
        this.label,})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return Button3DState();
  }
}

class Button3DState extends State<Button3D> {
  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return Container(
        child: InkWell(
          child: Container(
              padding: EdgeInsets.only(top: 8,bottom: 8,left: 20,right: 20),
              constraints:BoxConstraints(
                minWidth: 160,
              ),
              decoration:BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 6,color: Colors.grey),
                    left:BorderSide(width: 6,color:Colors.grey),
                    right:BorderSide(width: 6,color:Colors.white24),
                    bottom:BorderSide(width: 6,color:Colors.white24),
                  )
              )
          ),
        )
    );
  }
}