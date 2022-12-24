import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/resources/widgets/shared/notification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewPhoto extends StatefulWidget {
  const ViewPhoto({super.key});

  @override
  State<ViewPhoto> createState() => _ViewPhotoState();
}

class _ViewPhotoState extends State<ViewPhoto> {
  loadProfile() async {
    final user = Provider.of<UserProvider>(context, listen: false);
    bool isLogin = await user.checkAccount().then((value) => value);
    if (!isLogin) {
      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
          onWillPop: () async => false,
          child: DialogSession(
            onPress: () {
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacementNamed(context, "/login");
            },
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Foto Profile",
          style: TextStyle(color: Color(0XFFFAFAFA)),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: SizedBox(
          height: 240,
          width: double.infinity,
          child: Consumer<UserProvider>(
            builder: (context, value, child) {
              return value.dataUser.foto == "" ||
                      value.dataUser.foto == null ||
                      value.dataUser.foto == "null"
                  ? Image.asset("assets/image/profil_default.png")
                  : Image.network(
                      value.dataUser.foto!,
                      fit: BoxFit.cover,
                    );
            },
          ),
        ),
      ),
    );
  }
}
