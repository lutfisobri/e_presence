import 'package:e_presence/View/body/akun_page.dart';
import 'package:e_presence/View/body/jadwal_page.dart';
import 'package:e_presence/View/body/mapel_page.dart';
import 'package:e_presence/controller/API_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../body/home_page.dart';

class Beranda extends StatefulWidget {
  Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  List<Widget> body = [
    Home(),
    Mapel(),
    jadwal_page(),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final user = Provider.of<API_controller>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: (index == 3)
            ? akun_Page()
            : Container(
                color: Colors.white10,
                height: height,
                width: width,
                child: Column(
                  children: [
                    Container(
                      height: height / 12,
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: Consumer<API_controller>(
                        builder: (context, value, child) => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Selamat Datang!",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${user.user[0].name} - ${user.user[0].kelas}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            CircleAvatar(
                              radius: 23,
                              backgroundImage:
                                  NetworkImage(user.user[0].photoUrl),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 0),
                              blurRadius: 15,
                            )
                          ],
                        ),
                        child: Container(
                          padding: const EdgeInsets.only(
                            top: 15,
                          ),
                          child: (index < 3) ? body[index] : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Mapel",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Jadwal",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Akun",
          ),
        ],
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      ),
    );
  }
}
