import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SearchIconContoller extends GetxController{
  var isVisible = false.obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;

  void changeVisibitity(){
    isVisible.value == false?
    isVisible.value = true:
    isVisible.value = false;
  }
}