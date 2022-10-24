import 'package:e_presence/ui/shared/widgets/button_elevated.dart';
import 'package:e_presence/ui/shared/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetChangePassword extends StatefulWidget {
  const ForgetChangePassword({super.key});

  @override
  State<ForgetChangePassword> createState() => _ForgetChangePasswordState();
}

class _ForgetChangePasswordState extends State<ForgetChangePassword> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Ubah Kata Sandi"),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: GestureDetector(
          onTap: () {},
          child: SafeArea(
              child: Padding(
            padding: EdgeInsets.only(
              left: 18.r,
              right: 18.r,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                WidgetTextField(
                  label: Text(
                    "Password Baru*",
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      // color: const Color(0XFF494949),
                    ),
                  ),
                  primaryColor: Colors.black,
                  obscure: true,
                  sufixIcon1: Icon(Icons.visibility_off),
                  sufixIcon2: Icon(Icons.visibility),
                ),
                WidgetTextField(
                  label: Text(
                    "Konfirmasi Password Baru*",
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0XFF494949),
                    ),
                  ),
                  obscure: true,
                  sufixIcon1: Icon(Icons.visibility_off),
                  sufixIcon2: Icon(Icons.visibility),
                  primaryColor: Colors.black,
                ),
                SizedBox(
                  height: 6.5.r,
                ),
                WidgetEleBtn(
                  onPres: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Text("Ubah"),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
