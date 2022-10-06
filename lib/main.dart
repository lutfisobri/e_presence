import 'package:e_presence/View/child/detail_presensi.dart';
import 'package:e_presence/View/splash_screen.dart';
import 'package:e_presence/controller/api_controller.dart';
import 'package:e_presence/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApiController()),
        ChangeNotifierProvider(create: (_) => UserControlProvider()),
      ],
      child: const Main(),
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
    final api = Provider.of<ApiController>(context, listen: false);
    api.postUser();
    api.loadJadwal();
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      routes: {
        DetailPresensi.routeName: (context) => const DetailPresensi(),
      },
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
