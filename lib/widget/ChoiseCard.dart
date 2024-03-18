import 'package:flutter/material.dart';
import 'package:games/model/MJModel.dart';
import 'package:games/widget/newDropDown.dart';
import 'package:games/widget/widget.dart';

class ChoiseCard extends StatefulWidget {
  final Function onConfirm;
  final bool reversed;

  const ChoiseCard({
    Key key,
    @required this.onConfirm,
    this.reversed = false,
  }): super(key: key);

  @override
  ChoiseCardState createState() => ChoiseCardState();
}

class ChoiseCardState extends State<ChoiseCard> {
  String pattern = '';
  String number = '';
  List<Map> getNumberData(String pattern){
    if(pattern.isEmpty) return [];
    if(pattern == 'text'){
      List<MJType> textTypeList = MJType.values.skip(3).toList();
      return textTypeList.map((e) => {'display': e.getTCText, 'value': e.getText}).toList();
    }
    return List.generate(9, (index) => {'display': (index+1).toString(), 'value': (index+1).toString()});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(
          padding: EdgeInsets.all(16),
          child: NewDropDownFormField(
            titleText: 'Suit', // '花色',
            hintText: 'Choose Suit', // '選擇花色',
            value: pattern,
            reversed: widget.reversed,
            onChanged: (value) {
              setState(() {
                //清除數字下拉值
                if(pattern != value){
                  number = '';
                }
                pattern = value;
              });
            },
            dataSource: [
              {
                "display": "萬",
                "value": "wan",
              },
              {
                "display": "筒",
                "value": "ton",
              },
              {
                "display": "條",
                "value": "tiao",
              },
              {
                "display": "字",
                "value": "text",
              },
            ],
            textField: 'display',
            valueField: 'value',
          ),
        ),),
        Expanded(child: Container(
          padding: EdgeInsets.all(16),
          child: NewDropDownFormField(
            titleText: pattern == 'text' ? 'word' :'Number',
            hintText: pattern == 'text' ? 'Choose word' :'Choose Number',
            value: number,
            reversed: widget.reversed,
            onChanged: (value) {
              setState(() {
                number = value;
              });
            },
            dataSource: getNumberData(pattern),
            textField: 'display',
            valueField: 'value',
          ),
        ),),
        PrimaryButton(
          label: 'Confirm', // '確認選取',
          color:Colors.amber[900],
          onPressed: (){
            if(pattern.isEmpty || number.isEmpty) return;
            MJType type = MJTypeHelper.getMJType(pattern == 'text' ? number : pattern);
            int num = pattern == 'text' ? 0 : int.parse(number);
//            pattern = '';
//            number = '';
            widget.onConfirm(MJModel(type: type, num: num));
          },
        ),
      ],
    );
  }
}