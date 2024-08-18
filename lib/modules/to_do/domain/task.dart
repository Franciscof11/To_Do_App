import 'dart:convert';

class Task {
  final int? id;
  final String title;
  final String description;
  final int status;
  Task({
    this.id,
    required this.title,
    required this.status,
    required this.description,
  });

  Task copyWith({
    int? id,
    String? title,
    int? status,
    String? description,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      status: status ?? this.status,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'status': status,
      'description': description,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      status: map['status'] ?? 0,
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  @override
  String toString() => 'Task(id: $id, title: $title, status: $status, description: $description)';
}
