import 'package:flutter/material.dart';
import 'package:untitled5/cubit/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  double radius= 10.00 ,
  required String text  ,
  bool isUpperCase =true  ,
  required Function function,

})=>  Container(
  child: MaterialButton(
    onPressed: (){function();},// خلي بالك  here all onPressed Functions in the world should take anonymous function(){} then inside it we but what we need to take from the user function() , oo
    child: Text(
      isUpperCase ? text.toUpperCase() : text ,
      style: TextStyle(color: Colors.white),),

  ) ,
  width: width,
  height: 40.0,

  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color:background,
  ),

);



Widget defaultFormField({
  required TextEditingController controller ,
  required TextInputType type ,
  // required Function onSubmit,
  // required Function onChanged,
  // required Function validator,
  required String labelText,
  required IconData prefixIcon,
  IconData? suffixIcon,
  required bool isPassword  ,
  required String validatorText ,
  Function ? onPress ,
  Function ? onTap,
  bool ? isClick  ,

  Color iconColor = Colors.blue,

})  =>TextFormField(

  onTap: (){onTap!();},
  controller: controller,
  keyboardType: type ,
  // onFieldSubmitted: onSubmit(),
  // onChanged: onChanged(),
  enabled: isClick ,
  validator:
      ( value){
    if(value!.isEmpty){
      return validatorText;
    }
    return null ;
  },

  obscureText: isPassword ,
  decoration: InputDecoration(
    labelText: labelText,
    border: OutlineInputBorder(),
    prefixIcon: Icon(prefixIcon  ),

    suffixIcon:
    suffixIcon!=null ?  IconButton( icon:Icon(suffixIcon,color: iconColor,) ,
      onPressed:(){onPress!();} ,

    ) : null,

  ),
);


Widget buildTaskItem(Map model , context)=> Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        CircleAvatar(

          radius: 40.0,

          child: Text(

            '${model['time'] }',

          ),

        ),

        SizedBox(width: 20.0,),

        Expanded(

          child: Column(

            crossAxisAlignment:CrossAxisAlignment.start,

            mainAxisSize: MainAxisSize.min,

            children: [

              Text(

                '${model['title'] }',

                style: TextStyle(fontSize:  16.0 ,

                    fontWeight: FontWeight.bold

                ),



              ),

              Text(

                '${model['date'] }',

                style: TextStyle(

                  color: Colors.grey,

                ),



              ),



            ],),

        ),

        SizedBox(width: 20.0,),

        SizedBox(width: 20.0,),

        IconButton(

            onPressed: (){

              AppCubit.get(context).updateData(status: 'done', id :model['id']);

            },

            icon: Icon(Icons.check_box),

            color: Colors.green

          , ),

        IconButton(

          onPressed: (){

            AppCubit.get(context).updateData(status: 'archive', id :model['id']);



          },

          icon: Icon(Icons.archive),

          color: Colors.black45

        ),

      ],

    ),

  ),
  onDismissed: (direction){
    AppCubit.get(context).deleteData(id:model['id'] );

  },
);

