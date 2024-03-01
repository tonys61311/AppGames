class CubeModel {
  int count;
  bool isClick;
  bool haveBomb;
  bool haveFlag;
  int x;
  int y;
  int id;

  CubeModel({this.count, this.isClick = false, this.haveBomb, this.haveFlag = false,this.x,this.y,this.id});

  CubeModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    isClick = json['isClick'];
    haveBomb = json['haveBomb'];
    haveFlag = json['haveFlag'];
    x = json['x'];
    y = json['y'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['isClick'] = this.isClick;
    data['haveBomb'] = this.haveBomb;
    data['haveFlag'] = this.haveFlag;
    data['x'] = this.x;
    data['y'] = this.count;
    data['id'] = this.id;
    return data;
  }
}
