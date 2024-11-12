import 'package:get/state_manager.dart';

class IconController extends GetxController{
  final isList = true.obs;


  changeIcon(){
    isList.value == true ?
    isList.value = false:
    isList.value = true;
  }
}