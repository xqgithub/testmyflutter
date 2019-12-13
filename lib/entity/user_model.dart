import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

/**
 * UserModel类
 */

@JsonSerializable()
class UserModel {
  String name;
  int age;

  UserModel(this.name, this.age);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}