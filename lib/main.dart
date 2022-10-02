import 'package:e_presence/View/child/DetailPresensi.dart';
import 'package:e_presence/View/splashScreen.dart';
import 'package:e_presence/controller/API_controller.dart';
import 'package:e_presence/controller/User_Auth.dart';
import 'package:e_presence/controller/User_Location.dart';
import 'package:e_presence/controller/User_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => API_controller()),
        ChangeNotifierProvider(create: (_) => UserLocation()),
        ChangeNotifierProvider(create: (_) => userImage()),
        ChangeNotifierProvider(create: (_) => UserAuth()),
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
  UserLocation userLocation = UserLocation();

  loadData() async {
    userLocation.determinePosition();
    userLocation.setPosition();
  }

  @override
  void initState() {
    super.initState();
    // loadData();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<API_controller>(context, listen: false);
    user.postUser();
    user.loadJadwal();
    return MaterialApp(
      routes: {
        DetailPresensi.routeName: (context) => DetailPresensi(),
      },
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      // home: ChangeNotifierProvider(
      //   create: (context) => userLocation,
      //   child: SplashScreen(),
      // ),
    );
  }
}
