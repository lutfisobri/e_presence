import 'package:flutter/material.dart';

class edit_Profile extends StatelessWidget {
  const edit_Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text("Edit Profile"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
