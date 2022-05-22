import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/components/componantes.dart';
import 'package:untitled5/cubit/cubit.dart';
import 'package:untitled5/cubit/states.dart';
import 'package:untitled5/navigation_screens/archive.dart';
import 'package:untitled5/navigation_screens/done.dart';
import 'package:untitled5/navigation_screens/tasks.dart';
import 'package:intl/intl.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class HomeScreen extends StatelessWidget {

  var scaffoldKey = GlobalKey<ScaffoldState>() ;
  var formKey = GlobalKey<FormState>() ;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    return BlocProvider (
      create: (BuildContext context) =>AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit , AppStates>(
       listener:(BuildContext context ,AppStates state){
         if(state is InsertIntoDatabase ){
           Navigator.pop(context);
         }
       } ,
        builder:(BuildContext context ,AppStates state){
          AppCubit cubit = AppCubit.get(context) ;
          return Scaffold(
            key: scaffoldKey,
           appBar: AppBar(
            title: Text('${cubit.titles[cubit.currentIndex]}'),
          ),
          body: ConditionalBuilder(
            condition: true is! GEtDatabaseLoadingState,
            builder: (BuildContext context) {return cubit.screens[cubit.currentIndex] ;  },
            fallback: (BuildContext context) => Center(child: CircularProgressIndicator()) ,

          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if(cubit.showBottomSheet){
                if(formKey.currentState!.validate()){
                  cubit.insertIntoDatabase(
                    title: titleController.text,
                    date: dateController.text,
                    time: timeController.text ,
                  );
                  //     .then((value) {
                  //   cubit.getFromDatabase(cubit.database).then((value) {
                  //     Navigator.pop(context);
                  //     cubit.def= Icons.add;
                  //   });
                  // }) ;
                }

              }

              else{
                  scaffoldKey.currentState!.showBottomSheet((context) =>
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            defaultFormField(
                              prefixIcon: Icons.title,
                              controller: titleController,
                              validatorText: 'please inter the task name',
                              isPassword: false,
                              labelText: 'task name',
                              type: TextInputType.text,
                            ),
                            SizedBox(height: 20.0,),

                            defaultFormField(
                                prefixIcon: Icons.watch,
                                controller: timeController,
                                validatorText: 'please inter the time name',
                                isPassword: false,
                                isClick: true,
                                labelText: 'time',
                                type: TextInputType.text,
                                onTap: (){
                                  showTimePicker(
                                      context: context,
                                      initialTime:TimeOfDay.now()
                                  ).then((value) {
                                    timeController.text =value!.format(context);
                                    print(value.format(context));

                                  }) ;
                                }
                            ),
                            SizedBox(height: 20.0,),

                            defaultFormField(
                                prefixIcon: Icons.date_range,
                                controller: dateController,
                                isClick: true,
                                validatorText: 'please inter the date name',
                                isPassword: false,
                                labelText: 'date',
                                type: TextInputType.text,
                                onTap: (){
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2024-05-03'),
                                  ).then((value){
                                    dateController.text = DateFormat.yMMMd().format(value!) ;
                                  });
                                }
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                      elevation: 15.0
                  ).closed.then((value) {
                    cubit.changeBottomSheet(
                      icon:Icons.edit,
                      isShown: false,);

                  }) ;

                  cubit.changeBottomSheet(
                    icon:Icons.add,
                    isShown:true ,);

                  }


              

            },
            child: Icon(cubit.def),
          ),


          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index){
              cubit.changeIndex(index);
              // print(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.menu ,  ),
                label: 'tasks',

              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline  ),
                label: 'done',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.archive  ),
                label: 'archived',
              ),

            ],

          ),

        );} ,
      ),
    );
  }
}
