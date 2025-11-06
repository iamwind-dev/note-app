/// Model class representing a Note
/// Contains id, title, content, and creation/modification date
class NoteModel {
  final String id;
  String title;
  String content;
  DateTime dateTime;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.dateTime,
  });

  /// Create a copy of this note with updated fields
  NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? dateTime,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  /// Convert Note to Map for potential storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  /// Create Note from Map
  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      dateTime: DateTime.parse(map['dateTime']),
    );
  }
}
