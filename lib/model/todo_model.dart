import 'package:json_annotation/json_annotation.dart';
part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "description")
  final String desc;
  @JsonKey(name: "complete")
  final bool complete;

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return _$TodoModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TodoModelToJson(this);
  TodoModel({
    required this.id,
    required this.title,
    required this.desc,
    required this.complete,
  });

  TodoModel copyWith({
    int? id,
    String? title,
    String? desc,
    bool? complete,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      complete: complete ?? this.complete,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodoModel &&
        other.id == id &&
        other.title == title &&
        other.desc == desc &&
        other.complete == complete;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ desc.hashCode ^ complete.hashCode;
  }

  @override
  String toString() {
    return 'TodoModel(id: $id, title: $title, desc: $desc, complete: $complete)';
  }
}
