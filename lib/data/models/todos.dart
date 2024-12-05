import 'package:json_annotation/json_annotation.dart';

part 'todos.g.dart';

/// Run command in terminal - dart run build_runner build --delete-conflicting-outputs

@JsonSerializable()
class ToDos {
  final int id;
  final String? title;
  final int status;

  const ToDos({
    required this.id,
    required this.title,
    required this.status,
  });

  factory ToDos.fromJson(Map<String, dynamic> json) => _$ToDosFromJson(json);
  Map<String, dynamic> toJson() => {
        'title': this.title,
        'status': this.status,
      };

  @override
  String toString() {
    return 'ToDos{id: $id, title: $title, status: $status}';
  }
}
