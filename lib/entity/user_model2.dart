import 'package:json_annotation/json_annotation.dart';
import 'package:testmyflutter/entity/base_response.dart';
import 'package:testmyflutter/entity/book_model.dart';

part 'user_model2.g.dart';

/**
 * UserModel类
 */

@JsonSerializable()
class UserModel2 extends BaseResponse{
  UserModelReal data;

  UserModel2(this.data) : super(0, '');

  factory UserModel2.fromJson(Map<String, dynamic> json) =>
      _$UserModel2FromJson(json);

  Map<String, dynamic> toJson() => _$UserModel2ToJson(this);
}

@JsonSerializable()
class UserModelReal {
  String name;
  int age;
  BookModel book;

  UserModelReal(this.name, this.age, this.book);

  factory UserModelReal.fromJson(Map<String, dynamic> json) =>
      _$UserModelRealFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelRealToJson(this);
}