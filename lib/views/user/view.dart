import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/resources/widgets/shared/notifications/session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewPhoto extends StatefulWidget {
  const ViewPhoto({super.key});

  @override
  State<ViewPhoto> createState() => _ViewPhotoState();
}

class _ViewPhotoState extends State<ViewPhoto>
    with SingleTickerProviderStateMixin {
  late TransformationController controller;
  late AnimationController animitionController;
  Animation<Matrix4>? animation;
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
    controller = TransformationController();
    animitionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        controller.value = animation!.value;
      });
  }

  @override
  void dispose() {
    controller.dispose();
    animitionController.dispose();
    super.dispose();
  }

  final double min = 0.5;
  final double max = 9.0;

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
        child: InteractiveViewer(
          transformationController: controller,
          clipBehavior: Clip.none,
          panEnabled: false,
          minScale: min,
          maxScale: max,
          onInteractionEnd: (details) {
            resetAnimation();
          },
          child: Consumer<UserProvider>(
            builder: (context, value, child) {
              return value.dataUser.foto == "" ||
                      value.dataUser.foto == null ||
                      value.dataUser.foto == "null"
                  ? Image.asset(
                      "assets/image/profil_default.png",
                      fit: BoxFit.cover,
                    )
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

  void resetAnimation() {
    animitionController.reset();
    animation = Matrix4Tween(
      begin: controller.value,
      end: Matrix4.identity(),
    ).animate(
      CurvedAnimation(
        parent: animitionController,
        curve: Curves.easeIn,
      ),
    );
    animitionController.forward(from: 0);
  }
}
