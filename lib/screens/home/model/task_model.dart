class Task {
  final String id;
  final String title;
  final String ownerId;
  final List<String> sharedWith;
  final bool completed;

  Task({
    required this.id,
    required this.title,
    required this.ownerId,
    required this.sharedWith,
    required this.completed,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'ownerId': ownerId,
    'sharedWith': sharedWith,
    'completed': completed,
  };

  factory Task.fromMap(Map<String, dynamic> map) => Task(
    id: map['id'],
    title: map['title'],
    ownerId: map['ownerId'],
    sharedWith: List<String>.from(map['sharedWith']),
    completed: map['completed'],
  );
}