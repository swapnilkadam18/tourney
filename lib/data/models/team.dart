import 'package:equatable/equatable.dart';

class Team extends Equatable {
  int mId;
  String mImgPath;

  Team({int id, String imgPath}) {
    mId = id;
    mImgPath = imgPath;
  }

  @override
  List<Object> get props => [mId, mImgPath];

  @override
  bool get stringify => true;
}
