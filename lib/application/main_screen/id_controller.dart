import 'package:get/get.dart';

class IdController extends GetxController{
  var isVisible = false.obs;
  void changeVisibitity(){
    isVisible.value == false?
    isVisible.value  = true:
    isVisible.value = false;
  }
}