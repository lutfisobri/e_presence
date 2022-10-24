import 'package:e_presence/ui/pages/accounts/forget_password/change_password.dart';
import 'package:e_presence/ui/shared/widgets/button_elevated.dart';
import 'package:e_presence/ui/shared/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LupaPassword extends StatefulWidget {
  const LupaPassword({super.key});
  static const routeName = "/lupaPassword";

  @override
  State<LupaPassword> createState() => _LupaPasswordState();
}

class _LupaPasswordState extends State<LupaPassword> {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Cari Akun"),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 20.r, right: 20.r, top: 33.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WidgetTextField(
                  controller: controller,
                  focusNode: focusNode,
                  label: Text(
                    "Masukkan Username Anda",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: const Color(0XFF838383),
                    ),
                  ),
                  contenH: 15,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                  enableBorder: OutlineInputBorder(),
                  primaryColor: Color(0XFF0B0B0B),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: WidgetEleBtn(
                        onPres: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgetChangePassword(),
                              ));
                        },
                        textStyle: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        child: const Text("Cari"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
