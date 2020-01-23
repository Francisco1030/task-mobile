class Task {
  String description;
  bool completed;

  Task({ this.description, this.completed });

   factory Task.fromJson(Map<String, dynamic> map) {
    return Task(
        description: map["description"], completed: map["completed"]);
  }
}