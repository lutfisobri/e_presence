import 'package:e_presence/core/providers/api_controller.dart';
import 'package:e_presence/ui/shared/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AkunPage extends StatefulWidget {
  AkunPage({super.key});

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  final styleThemeData = StyleThemeData();
  @override
  void initState() {
    super.initState();
    loadApi();
  }

  void loadApi() {
    final api = Provider.of<ApiController>(context, listen: false);
    api.loadJadwal();
    api.postUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (context, maxHeight) {
        return Consumer<ApiController>(
          builder: (context, value, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 25.r, left: 20.54.r, right: 25.r),
                height: maxHeight.maxHeight - 537.h,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      child: CircleAvatar(
                        backgroundImage: value.getUser.isNotEmpty
                            ? NetworkImage(value.getUser[0].photoUrl)
                            : null,
                        maxRadius: 35.r,
                      ),
                    ),
                    Positioned(
                      left: 82.r,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value.getUser[0].name,
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            value.getUser[0].username,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 17.47.r,
                          ),
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, "/editProfile"),
                            child: const Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 13.74.r,
              ),
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(
                    minWidth: double.infinity,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(
                    top: 19.r,
                    left: 19.r,
                    right: 19.r,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pengaturan Akun",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 19.r,
                      ),
                      ListTile(
                        leading: const Icon(Icons.edit),
                        title: const Text("Ubah Kata Sandi"),
                        onTap: () =>
                            Navigator.pushNamed(context, "/ubahPassword"),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.logout),
                        title: const Text("Keluar"),
                        onTap: () =>
                            Navigator.pushReplacementNamed(context, "/login"),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
