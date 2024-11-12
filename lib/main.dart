import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_app_getx/core/constant_size/size.dart';
import 'package:student_app_getx/infrastucture/model/student_model.dart';
import 'package:student_app_getx/presentation/main_screen/main_screen.dart';

Future<void> main() async{
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(const StudentAppGetX());
}

class StudentAppGetX extends StatelessWidget {
  const StudentAppGetX({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.initialize(context);
    return  MaterialApp(
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
    
  }
}
