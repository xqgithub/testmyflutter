import 'package:json_annotation/json_annotation.dart';

part 'book_model.g.dart';

/**
 * BookModel类
 */

@JsonSerializable()
class BookModel {
  int id;
  String name;

  BookModel(this.id, this.name);

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookModelToJson(this);

}
