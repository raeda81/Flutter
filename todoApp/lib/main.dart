import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/styles/bloc_observer.dart';
import 'layout/home_layout.dart';

void main() {

    BlocOverrides.runZoned(
          () {

            runApp(MyApp());
        // Use cubits...
      },
      blocObserver: MyBlocObserver(),
    );


}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:HomeScreen(),
      debugShowCheckedModeBanner: false,

    );
  }
}

