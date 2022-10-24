import 'package:e_presence/core/providers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewPhoto extends StatelessWidget {
  const ViewPhoto({super.key});

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
              return Image.network(value.dataUser.photo, fit: BoxFit.cover,);
            },
          ),
        ),
      ),
    );
  }
}
