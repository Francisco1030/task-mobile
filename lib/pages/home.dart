import 'package:flutter/material.dart';
import 'package:task/model/task.dart';
import 'package:task/pages/form_task.dart';
import 'package:task/service/api_service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  BuildContext context;
  ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed('/form-task');
                },
              )
            ],
            title: Text(
              "Lista de tarefas",
              style: TextStyle(color: Colors.white),
            )),
        body: SafeArea(
          child: FutureBuilder(
            future: apiService.getTasks(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                      "Something wrong with message: ${snapshot.error.toString()}"),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                List<Task> tasks = snapshot.data;
                return _buildListView(tasks);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }
}

Widget _buildListView(List<Task> tasks) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    child: ListView.builder(
      itemBuilder: (context, index) {
        Task task = tasks[index];
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    task.description,
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text("ID: " + task.id),
                  //Text(profile.age.toString()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          //     showDialog(
                          //         context: context,
                          //         builder: (context) {
                          //           return AlertDialog(
                          //             title: Text("Warning"),
                          //             content: Text(
                          //                 "Are you sure want to delete data profile ${task.description}?"),
                          //             actions: <Widget>[
                          //               FlatButton(
                          //                 child: Text("Yes"),
                          //                 onPressed: () {
                          //                   Navigator.pop(context);
                          //                   apiService.deleteTask(task.id)
                          //                       .then((isSuccess) {
                          //                     if (isSuccess) {
                          //                       setState(() {});
                          //                       Scaffold.of(context)
                          //                           .showSnackBar(SnackBar(
                          //                               content: Text(
                          //                                   "Delete data success")));
                          //                     } else {
                          //                       Scaffold.of(context)
                          //                           .showSnackBar(SnackBar(
                          //                               content: Text(
                          //                                   "Delete data failed")));
                          //                     }
                          //                   });
                          //                 },
                          //               ),
                          //               FlatButton(
                          //                 child: Text("No"),
                          //                 onPressed: () {
                          //                   Navigator.pop(context);
                          //                 },
                          //               )
                          //             ],
                          //           );
                          // });
                        },
                        child: Text(
                          "Deletar",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FormTask(task: task),
                            ),
                          );
                          //Navigator.of(context).pushNamed('/form-task/task');
                        },
                        child: Text(
                          "Editar",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: tasks.length,
    ),
  );
}
