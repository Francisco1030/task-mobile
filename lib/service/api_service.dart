import '../model/task.dart';
import 'package:http/http.dart' show Client;

class ApiService {

  final String baseUrl = "http://localhost:3000";
  Client client = Client();

  Future<List<Task>> getTasks() async {
    final response = await client.get("$baseUrl/tasks");
    if (response.statusCode == 200) {
      return Task.taskFromJson(response.body);
    } else {
      return null;
    }
  }

}
