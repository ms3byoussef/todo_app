// ignore_for_file: avoid_print, must_call_super

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/business_logic/cubit/states.dart';
import 'package:todo/db/models/task.dart';

class AppCubit extends Cubit<TaskStetes> {
  AppCubit() : super(TaskInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Task> allTasks = [];
  List<Task> compalteTasks = [];
  List<Task> unComplateTasks = [];
  List<Task> favTasks = [];

  Database? database;
  void createDataBase() {
    openDatabase('tasks.db', version: 1, onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE $tableTasks(id INTEGER PRIMARY KEY, title TEXT, note TEXT, date STRING, startTime STRING, endTime STRING, color INTEGER, remind INTEGER, repeat STRING, isFavorite INTEGER, isCompleted INTEGER)')
          .then((value) {});
    }, onOpen: (database) {
      selectFromDatabase(database);
    }).then((value) {
      database = value;
    });
    emit(DatabaseInitialized());
  }

  Future<void> insertIntoDatabase({Task? task}) async {
    await database!.transaction((txn) {
      allTasks = [];
      return txn.insert(tableTasks, task!.toJson()).then((value) {
        emit(TaskCreated());
        print(value);
        selectFromDatabase(database);
      }).catchError((e) {});
    });
  }

  void updateToDatebase(int isCompleted, int? id) {
    database!.execute('UPDATE tasks SET isCompleted =? WHERE id=?',
        [isCompleted, id]).then((value) {
      emit(UpdateTaskState());
      allTasks = [];
      compalteTasks = [];
      unComplateTasks = [];
      favTasks = [];

      selectFromDatabase(database);
    });
  }

  void updateIsFavoriteDatebase(int isFavorite, int? id) {
    database!.execute('UPDATE tasks SET isFavorite =? WHERE id=?',
        [isFavorite, id]).then((value) {
      emit(UpdateTaskState());
      allTasks = [];
      compalteTasks = [];
      unComplateTasks = [];
      favTasks = [];

      selectFromDatabase(database);
    });
  }

  void deleteFromDatabase(int? id) {
    database!.execute('DELETE FROM tasks WHERE id =?', [id]);
    allTasks = [];
    compalteTasks = [];
    unComplateTasks = [];
    favTasks = [];
    emit(DeleteTask());
    selectFromDatabase(database);
  }

  void selectFromDatabase(database) {
    database!.rawQuery("SELECT * FROM tasks").then((value) {
      value.forEach((element) {
        Task task = Task.fromJson(element);
        if (task.isCompleted == 1 || task.isCompleted == 0) {
          allTasks.add(task);
        } else if (task.isCompleted == 1) {
          compalteTasks.add(task);
        } else if (task.isCompleted == 0) {
          unComplateTasks.add(task);
        } else if (task.isFavorite == 1) {
          favTasks.add(task);
        }
      });

      emit(SelectTask());
    });
  }

  // void createTask(Task task) {
  //   try {
  //     if (dateController.text.isNotEmpty &&
  //         titleController.text.isNotEmpty &&
  //         timeController.text.isNotEmpty) {
  //       insertIntoDatabase(
  //               title: titleController.text,
  //               date: dateController.text,
  //               time: timeController.text,
  //               description: descriptionController?.text)
  //           .then((value) {
  //         print("Create Task");
  //       });
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }

  //   // emit(CreateFormState());
  // }

  @override
  Future close() async {
    final db = database;
    db!.close();
  }
}
