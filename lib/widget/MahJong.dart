import 'package:flutter/material.dart';

class MohJong extends StatefulWidget {

  const MohJong(
      {Key key,})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return MohJongState();
  }
}

class MohJongState extends State<MohJong> {

  Widget getContent(){

    return Container();
  }

  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return Container(
      alignment: Alignment.center,
      width: 100,
      height: 100,
      child: getContent(),
      decoration: BoxDecoration(
        border: new Border.all(color: Color(0xFFFF0000), width: 0.5), // 边色与边宽度
        color: Color(0xFF9E9E9E), // 底色
        borderRadius: new BorderRadius.circular((20.0)), // 圆角度
        // 生成俩层阴影，一层绿，一层黄， 阴影位置由offset决定,阴影模糊层度由blurRadius大小决定（大就更透明更扩散），阴影模糊大小由spreadRadius决定
        boxShadow: [BoxShadow(color: Color(0x99FFFF00), offset: Offset(5.0, 5.0),    blurRadius: 10.0, spreadRadius: 2.0), BoxShadow(color: Color(0x9900FF00), offset: Offset(1.0, 1.0)), BoxShadow(color: Color(0xFF0000FF))],
      ),
    );
  }
}