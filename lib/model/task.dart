import 'dart:convert';

class Task {
  String description;
  bool completed;

  Task({this.description, this.completed});

  factory Task.fromJson(Map<String, dynamic> map) {
    return Task(description: map["description"], completed: map["completed"]);
  }

  Map<String, dynamic> toJson() {
    return {"description": description, "completed": completed};
  }

  @override
  String toString() {
    return 'Task{description: $description, completed: $completed}';
  }

  List<Task> taskFromJson(String jsonData) {
    final data = json.decode(jsonData);
    return List<Task>.from(data.map((item) => Task.fromJson(item)));
  }
}
