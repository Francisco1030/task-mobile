import 'package:flutter/material.dart';
import 'package:task/pages/form_task.dart';
import 'package:task/pages/home.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: MyHomePage(title: 'Teste do app'),
      routes: {
        '/': (context) => Home(),
        '/form-task': (context) => FormTask(),
        '/form-task/task': (context) => FormTask(),
        //'/menu': (context) => DrawerCustom(),
      },
    );
  }
}