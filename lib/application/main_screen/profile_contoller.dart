import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;


 class ProfileController extends GetxController {
  var profileImage = 'default_path'.obs;

  Future<void> pickImageFormGallery() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final File imageFile = File(pickedFile.path);
        final String permanentPath = await saveImagePermanently(imageFile);
        profileImage.value = permanentPath; 
      }
    } catch (e) {
   //  print('Error picking image: $e');
    }
  }

  Future<String> saveImagePermanently(File imageFile) async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String fileName = path.basename(imageFile.path);
    final String newPath = path.join(appDocDir.path, fileName);

    final File newImageFile = await imageFile.copy(newPath);
    return newImageFile.path; 
  }

  void disposeImage(){
  profileImage = 'default_path'.obs;
}

}