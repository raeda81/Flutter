import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/cubit/states.dart';
import 'package:untitled5/navigation_screens/archive.dart';
import 'package:untitled5/navigation_screens/done.dart';
import 'package:untitled5/navigation_screens/tasks.dart';
import 'package:sqflite/sqflite.dart';


class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(InitialState());

////////////////////////////////  -creation of object-  ///////////////////////
  static AppCubit get(context) => BlocProvider.of(context) ;



///////////////////////////////////////////////////////////////////////////////
  int currentIndex = 0 ;
List <String> titles =[
  'tasks',
  'done',
  'archived'
  ];
List <Widget> screens =[
  TaskScreen(),
  DoneScreen(),
  ArchiveScreen(),
];


void changeIndex(int index ){

    currentIndex = index ;
    emit(ChangeNavigationBarState());
  }
///////////////////////////////////////////////////////////////////////////////






////////////////////////////////  -creation of database-  ///////////////////////////////////////////////
late Database database ;

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];


  void createDatabase(){

  openDatabase(
    'todo.dp',
    version: 1,
    onCreate: (Database db, int version) {
       db.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY , title TEXT , date TEXT , time TEXT , status)').then((value) {
        print('the creation is done ');
      }).catchError((error){
        print('error while creating the table $error ');
      });
    },// on create

    onOpen: (database){
      getFromDatabase(database);
      print('the database open is done  ');
    },// open

  ).then((value) {
    database =value ;
    emit(CreateDatabase());
  });
}

 insertIntoDatabase({
  required String title,
  required String date,
  required String time,}
    ) async{
  await database.transaction((txn) async{
    txn.rawInsert('INSERT INTO tasks(title, date, time , status) VALUES("$title","$date","$time" , "new status")').then((value) {
      print('the $value insert is done ');
      emit(InsertIntoDatabase());
      getFromDatabase(database);
    }).catchError((error){print('an error while inserting in to the table $error');}) ;
    return null;
  }) ;
}


void updateData({required String status, required int id,}) async{
     database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id]).then((value) {
       getFromDatabase(database);
        emit(UpdateIntoDatabase());
     });}


  void deleteData({ required int id,}) async{
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getFromDatabase(database);
      emit(DeleteFromDatabase());
    });}


  void getFromDatabase(database) {
    newTasks= [];
    doneTasks= [];
    archiveTasks= [];


    emit(GEtDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      // tasks = value ;
    value.forEach((element) {
      if(element['status'] == 'new status')
        newTasks.add(element);
         else if(element['status'] == 'done')
        doneTasks.add(element);
        else archiveTasks.add(element);

      });

    emit(GEtFromDatabase());

  });
  emit(GEtFromDatabase());

}
///////////////////////////////////////////////////////////////////////////////




///////////////////////////////////////////////////////////////////////////////
  bool showBottomSheet = false;
  IconData def = Icons.edit;

  void changeBottomSheet({
    required bool isShown ,
    required IconData icon ,

  }){
    showBottomSheet = isShown;
     def =icon ;
     emit(ChangeBottomSheetState());

  }
///////////////////////////////////////////////////////////////////////////////


}