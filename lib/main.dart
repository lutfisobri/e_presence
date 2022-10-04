import 'package:e_presence/View/child/DetailPresensi.dart';
import 'package:e_presence/View/splashScreen.dart';
import 'package:e_presence/controller/API_controller.dart';
import 'package:e_presence/controller/User_Controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => API_controller()),
        ChangeNotifierProvider(create: (_) => UserControlProvider()),
      ],
      child: Main(),
    ),
  );
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  UserControlProvider userLocation = UserControlProvider();

  loadData() async {
    userLocation.determinePosition();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<API_controller>(context, listen: false);
    user.postUser();
    user.loadJadwal();
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      routes: {
        DetailPresensi.routeName: (context) => DetailPresensi(),
      },
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
