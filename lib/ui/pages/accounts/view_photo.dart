import 'package:e_presence/core/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewPhoto extends StatefulWidget {
  const ViewPhoto({super.key});

  @override
  State<ViewPhoto> createState() => _ViewPhotoState();
}

class _ViewPhotoState extends State<ViewPhoto> {
  loadProfile() {
    var user = Provider.of<UserControlProvider>(context, listen: false);
    user.checkAccount();
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
          child: Consumer<UserControlProvider>(
            builder: (context, value, child) {
              return value.dataUser.foto == ""
                  ? Image.asset("assets/image/profil_default.png")
                  : Image.network(
                      value.dataUser.foto,
                      fit: BoxFit.cover,
                    );
            },
          ),
        ),
      ),
    );
  }
}
