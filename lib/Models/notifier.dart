import 'package:flutter/material.dart';

import 'task.dart';

class Notifier extends ChangeNotifier {
  List<Task> taskList = []; //contians all the task

  addTaskInList(title, date) {
    Task taskModel = Task(titleFinal: title, dateFinal: date);
    taskList.add(taskModel);

    notifyListeners();
  }

  deleteTask(ind) {
    taskList.removeAt(ind);
  }
}
