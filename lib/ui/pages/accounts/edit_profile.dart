import 'package:e_presence/core/providers/api_controller.dart';
import 'package:e_presence/ui/shared/theme_data.dart';
import 'package:e_presence/ui/shared/widgets/button_elevated.dart';
import 'package:e_presence/ui/shared/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});
  static const routeName = "/editProfile";
  final styleThemeData = StyleThemeData();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 90.r,
                        height: 90.r,
                        child: Consumer<ApiController>(
                          builder: (context, value, child) => ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image(
                              image: NetworkImage(value.getUser[0].photoUrl),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 28.28.r,
                    ),
                    Text(
                      "Nama Lengkap *",
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0XFF858585),
                      ),
                    ),
                    Consumer<ApiController>(builder: (context, value, child) {
                      return WidgetTextField(
                        initialValue: value.getUser[0].name,
                        contenH: 0,
                        enable: false,
                        style: TextStyle(
                          color: const Color(0XFF858585),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        disableBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.5,
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      height: 18.5.r,
                    ),
                    Text(
                      "E-mail *",
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0XFF858585),
                      ),
                    ),
                    Consumer<ApiController>(builder: (context, value, child) {
                      return WidgetTextField(
                        initialValue: value.getUser[0].username,
                        contenH: 0,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600),
                        focusBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Nisn *",
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0XFF858585),
                      ),
                    ),
                    Consumer<ApiController>(
                      builder: (context, value, child) {
                        return WidgetTextField(
                          initialValue: value.getUser[0].username,
                          contenH: 0,
                          style: TextStyle(
                            color: const Color(0XFF858585),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          enable: false,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Tanggal Lahir *",
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0XFF858585),
                      ),
                    ),
                    WidgetTextField(
                      onTap: () {},
                      readOnly: true,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      sufixIcon1: const Icon(Icons.calendar_month),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Kelas *",
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0XFF858585),
                      ),
                    ),
                    Consumer<ApiController>(builder: (context, value, child) {
                      return WidgetTextField(
                        enable: false,
                        initialValue: value.getUser[0].kelas,
                        style: TextStyle(
                          color: const Color(0XFF858585),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        WidgetEleBtn(
                          onPres: () {},
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.77.r),
                          ),
                          textStyle: TextStyle(fontSize: 12.6.sp),                          
                          child: Text("Simpan"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 60.45.r,
                left: 196.2.r,
                right: 131.4.r,
                child: Container(
                  height: 30.6.h,
                  width: 30.6.w,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {},
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
