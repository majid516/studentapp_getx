import 'package:flutter/material.dart';
import 'package:student_app_getx/application/main_screen/id_controller.dart';
import 'package:student_app_getx/core/constant_colors/colors.dart';
import 'package:student_app_getx/core/constant_size/size.dart';

class ShowUserIdButton extends StatelessWidget {
  const ShowUserIdButton({
    super.key,
    required this.idController,
  });

  final IdController idController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 120,
      left: 60,
      right: 60,
      child: ElevatedButton(
        onPressed: () {
          idController.changeVisibitity();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: whiteColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          fixedSize: Size(ScreenSize.width * 0.3, 40),
          elevation: 1,
        ),
        child: const Wrap(
          children: [
            Icon(
              Icons.remove_red_eye_outlined,
              color: appThemeColor,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'show student Id',
              style: TextStyle(color: appThemeColor),
            ),
          ],
        ),
      ),
    );
  }
}
