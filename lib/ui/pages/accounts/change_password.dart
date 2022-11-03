import 'package:e_presence/core/providers/user_provider.dart';
import 'package:e_presence/ui/shared/theme_data.dart';
import 'package:e_presence/ui/shared/widgets/button_elevated.dart';
import 'package:e_presence/ui/shared/widgets/bottomShet.dart';
import 'package:flutter/material.dart';
import 'package:e_presence/ui/shared/widgets/text_field.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});
  static const routeName = "/changePassword";

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController pwLama = TextEditingController();
  final TextEditingController pwBaru = TextEditingController();
  final TextEditingController confpwBaru = TextEditingController();

  final styleThemeData = StyleThemeData();

  @override
  void dispose() {
    pwLama.dispose();
    pwBaru.dispose();
    confpwBaru.dispose();
    super.dispose();
  }

  btnChange() async {
    final user = Provider.of<UserControlProvider>(context, listen: false);
    await user.changePassword(pwBaru.text).then((value) {
      if (value) {
        showDialog(
          context: context,
          builder: (context) => Dialog(),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => Dialog(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Ubah Kata Sandi",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WidgetTextField(
                    controller: pwLama,
                    obscure: true,
                    label: Text(
                      "Password Lama*",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    sufixIcon1: const Icon(
                      Icons.visibility_off,
                      color: Colors.black,
                    ),
                    sufixIcon2: const Icon(
                      Icons.visibility,
                      color: Colors.black,
                    ),
                    primaryColor: Colors.black,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  WidgetTextField(
                    controller: pwBaru,
                    obscure: true,
                    label: Text(
                      "Password Baru*",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    sufixIcon1: const Icon(
                      Icons.visibility_off,
                      color: Colors.black,
                    ),
                    sufixIcon2: const Icon(
                      Icons.visibility,
                      color: Colors.black,
                    ),
                    primaryColor: Colors.black,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  WidgetTextField(
                    controller: confpwBaru,
                    obscure: true,
                    label: Text(
                      "Konfirmasi Password Baru*",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    sufixIcon1: const Icon(
                      Icons.visibility_off,
                      color: Colors.black,
                    ),
                    sufixIcon2: const Icon(
                      Icons.visibility,
                      color: Colors.black,
                    ),
                    primaryColor: Colors.black,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 16.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      WidgetEleBtn(
                        onPres: () {
                          connectionError(context);
                          // if (pwBaru.text.isEmpty || pwBaru.text == "") {

                          // }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.77),
                        ),
                        minimunSize: Size(109, 46),
                        textStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                        child: const Text("UBAH"),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
