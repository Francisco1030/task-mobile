import 'package:flutter/material.dart';
import 'package:task/model/task.dart';
import 'package:task/service/api_service.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class FormTask extends StatefulWidget {
  @override
  _FormTask createState() => _FormTask();
}

class _FormTask extends State<FormTask> {
  bool _isLoading = false;
  ApiService _apiService = ApiService();
  bool _isFieldDescriptionValid;
  bool _isFieldCompletedValid;
  TextEditingController _controllerDescription = TextEditingController();
  TextEditingController _controllerCompleted = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Cadastrar Tarefa",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldDescription(),
               // _buildTextFieldCompleted(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_isFieldDescriptionValid == null ||
                          _isFieldCompletedValid == null ||
                          !_isFieldDescriptionValid ||
                          !_isFieldCompletedValid) {
                        _scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Por favor preencha todos os campos"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String description = _controllerDescription.text.toString();
                      bool completed = bool.fromEnvironment(_controllerCompleted.text.toString());
      
                      Task task =
                          Task(description: description, completed: completed);
                      _apiService.createTask(task).then((isSuccess) {
                        setState(() => _isLoading = false);
                        if (isSuccess) {
                          Navigator.pop(_scaffoldState.currentState.context);
                        } else {
                          _scaffoldState.currentState.showSnackBar(SnackBar(
                            content: Text("Falha no envio de dados"),
                          ));
                        }
                      });
                    },
                    child: Text(
                      "Enviar".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.orange[600],
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildTextFieldDescription() {
    return TextField(
      controller: _controllerDescription,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Descrição",
        errorText: _isFieldDescriptionValid == null || _isFieldDescriptionValid
            ? null
            : "Preecha o campo",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldDescriptionValid) {
          setState(() => _isFieldDescriptionValid = isFieldValid);
        }
      },
    );
  }

  // Widget _buildTextFieldCompleted() {
  //   return ListTile(
  //     controller: _controllerCompleted,
  //     //keyboardType: TextInputType.emailAddress,
  //     decoration: InputDecoration(
  //       labelText: "Status ",
  //       errorText: _isFieldCompletedValid == null || _isFieldCompletedValid
  //           ? null
  //           : "Email is required",
  //     ),
  //     onChanged: (value) {
  //       bool isFieldValid = value.trim().isNotEmpty;
  //       if (isFieldValid != _isFieldEmailValid) {
  //         setState(() => _isFieldEmailValid = isFieldValid);
  //       }
  //     },
  //   );
  // }

}