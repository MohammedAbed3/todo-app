import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/Modules/TodoAppScreens/ArchiveScreen.dart';
import 'package:untitled2/Modules/TodoAppScreens/TaskScreen.dart';
import 'package:untitled2/shared/HomeScreenCubit/Stetes.dart';
import 'package:sqflite/sqflite.dart';

import '../../Modules/TodoAppScreens/DoneScreen.dart';

class AppCubit extends Cubit<AppStets> {
  AppCubit() : super(AppInitialState());

  Database? database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];
  bool isBottomSheetOpened = false;
  IconData fabIcon = Icons.edit;

  int bnbSelected = 0;
  List<Widget> screen = [
    Taskscreen(),
    DoneScreen(),
    ArchiveScreen(),
  ];

  static AppCubit get(context) => BlocProvider.of(context);

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database Created');

        database.execute('CREATE TABLE tasks'
                ' (id INTEGER PRIMARY KEY,'
                ' title TEXT , date TEXT ,'
                ' time TEXT,'
                'status TEXT)')
            .then(
          (value) {
            print('TABLE Created');
          },
        ).catchError((e) {
          print('error TABLE Created ${e.toString()}');
        });
      },
      onOpen: (database) {
        print('database opned');
        getDateFromDatabase(database);
      },
    ).then(
      (value) {
        database = value;
        emit(AppCreateDatabaseState());
      },
    );
  }

  insertIntoDatabase(String title, String date, String time) async {
    await database
        ?.transaction(
          (txn) {
            txn
                .rawInsert(
                    'INSERT INTO tasks(title, date ,time , status) VALUES("$title", "$date", "$time", "new")')
                .then(
              (value) {
                print('successfully insert INTO dataabse');
                emit(AppInsertDatabaseState());

                getDateFromDatabase(database);
              },
            ).catchError((error) {
              print('filed to  insert INTO dataabse');
            });

            return Future.value();
          },
        )
        .then(
          (value) {},
        )
        .catchError((onError) {});
  }

  void getDateFromDatabase(database)  {

    newTasks = [];
    doneTasks = [];
    archiveTasks = [];

     database!.rawQuery('SELECT * FROM tasks').then(
          (value) {

        value.forEach((element){

          if (element['status'] == 'new'){
            newTasks.add(element);

          }else if (element['status'] == 'done'){
            doneTasks.add(element);

          }else{
            archiveTasks.add(element);


          }

        });

        emit(AppGetDatabaseState());


      },
    );;
  }

  void updateDate({
    required String status,
    required int id,
  }) async {
    return  database!
        .rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        [status, id],
    ).then((value) {
      getDateFromDatabase(database);
          emit(AppUpdateDatabaseState());
        },);

  }

  void deleteDate({required int id}) async {
    database!.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    ).then((value) {
      getDateFromDatabase(database); // استدعاء تحديث البيانات بعد الحذف
      emit(AppDeleteDatabaseState()); // تحديث الحالة بعد الحذف
    }).catchError((error) {
      print('Error while deleting record: $error');
    });
  }


  void changeScreen(int newScreen) {
    bnbSelected = newScreen;
    emit(AppChangeScreenState());
  }

  void changeBottomSheetState(bool isOpen, IconData icon) {
    isBottomSheetOpened = isOpen;
    fabIcon = icon;
    emit(ChangeBottomSheetState());
  }
}
