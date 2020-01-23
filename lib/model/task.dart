class Task {
  String description;
  bool completed;

  Task({ this.description, this.completed });

   factory Task.fromJson(Map<String, dynamic> map) {
    return Task(
        description: map["description"], completed: map["completed"]);
  }

   Map<String, dynamic> toJson() {
    return {"description": description, "completed": completed};
  }  

   @override
  String toString() {
    return 'Task{description: $description, completed: $completed}';
  }

}