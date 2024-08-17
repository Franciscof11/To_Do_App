import 'dart:convert';

class Task {
  final int id;
  final String title;
  final String description;
  final int isDone;
  Task({
    required this.id,
    required this.title,
    required this.isDone,
    required this.description,
  });

  Task copyWith({
    int? id,
    String? title,
    int? isDone,
    String? description,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({
      'id': id
    });
    result.addAll({
      'title': title
    });
    result.addAll({
      'isDone': isDone
    });
    result.addAll({
      'description': description
    });

    return result;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      isDone: map['isDone'] ?? 0,
      description: map['description'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  @override
  String toString() => 'Task(id: $id, title: $title, isDone: $isDone, description: $description)';
}
