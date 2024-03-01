import 'package:flutter/material.dart';
import 'package:games/model/CubeModel.dart';

class Cube extends StatefulWidget {
  final CubeModel data;
  final VoidCallback onTap; //按下動作
  final VoidCallback onLongPress; //長按動作

  const Cube(
      {Key key,
        this.data,
        this.onTap,
        this.onLongPress,
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return CubeState();
  }
}

class CubeState extends State<Cube> {
  Widget getNumText(int num){
    List<Color> colorList = [Colors.grey,Colors.green[800],Colors.brown[700],Colors.blueAccent[400],Colors.deepOrange[900],Colors.pinkAccent[700],Colors.lime,Colors.teal,Colors.lightBlueAccent];
    Map mapping = colorList.asMap();
    return Text(
      (num??'').toString(),
      style: TextStyle(
        color: mapping[num??0],
        fontSize: 22,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget getContent(){
    if(widget.data.isClick){
      return widget.data.haveBomb?Icon(Icons.mood_bad,color: Colors.red[900],)
          :getNumText(widget.data.count);
    }
    if(widget.data.haveFlag){
      return Icon(Icons.flag);
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return GestureDetector(
      onTap: (){
        if(widget.onTap != null){
          widget.onTap();
        }
      },
      onLongPress: (){
        if(widget.onLongPress != null){
          widget.onLongPress();
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: 30,
        height: 30,
        child: getContent(),
        decoration: new BoxDecoration(
          color: widget.data.isClick && widget.data.haveBomb ?Colors.grey:Colors.grey,
//        borderRadius: BorderRadius.all(Radius.circular(10.0)),
          border: widget.data.isClick
              ? Border.all(width: 2,color: Colors .black12)
              :Border(
            top: BorderSide(width: 2,color: Colors.white),
            left: BorderSide(width: 2,color: Colors.white),
            right: BorderSide(width: 2,color: Colors.black26),
            bottom: BorderSide(width: 2,color: Colors.black26),
          ),
        ),
      ),
    );
  }
}