// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel2 _$UserModel2FromJson(Map<String, dynamic> json) {
  return UserModel2(json['data'] == null
      ? null
      : UserModelReal.fromJson(json['data'] as Map<String, dynamic>))
    ..code = json['code'] as int
    ..msg = json['msg'] as String;
}

Map<String, dynamic> _$UserModel2ToJson(UserModel2 instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data
    };

UserModelReal _$UserModelRealFromJson(Map<String, dynamic> json) {
  return UserModelReal(
      json['name'] as String,
      json['age'] as int,
      json['book'] == null
          ? null
          : BookModel.fromJson(json['book'] as Map<String, dynamic>));
}

Map<String, dynamic> _$UserModelRealToJson(UserModelReal instance) =>
    <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'book': instance.book
    };
