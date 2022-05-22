import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/components/componantes.dart';
import 'package:untitled5/cubit/cubit.dart';
import 'package:untitled5/cubit/states.dart';

class ArchiveScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context,AppStates state ) {  },
      builder: (BuildContext context, AppStates state) {
        AppCubit cubit = AppCubit.get(context) ;
        // var tasks =AppCubit.get(context).doneTasks ;
        return  ConditionalBuilder(
            condition: cubit.archiveTasks.length>0,
            builder: (context)=>ListView.separated(
              itemBuilder: (context ,index)=>buildTaskItem( cubit.archiveTasks[index] , context),
              separatorBuilder:(context ,index)=>Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 20.0
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ) ,
              itemCount: cubit.archiveTasks.length ,),
            fallback: (context)=> Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu,
                    size: 100.0,
                    color: Colors.grey,
                  ),
                  Text(
                    'no tasks yet, please could you inter or fill some of it ',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey

                    ),
                  )
                ],),
            )   ) ;},

    );
  }
}
