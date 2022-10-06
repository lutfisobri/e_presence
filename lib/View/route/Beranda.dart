import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/api_controller.dart';
import '../body/Jadwal_page.dart';
import '../body/akun_page.dart';
import '../body/home_page.dart';
import '../body/mapel_page.dart';

class Beranda extends StatefulWidget {
  Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  List<Widget> body = [
    Home(),
    Mapel(),
    JadwalPage(),
  ];

  Color colorGreen = const Color.fromARGB(255, 114, 182, 108);

  int index = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final api = Provider.of<ApiController>(context, listen: false);
    api.loadJadwal;
    api.postUser();
    return Scaffold(
      body: Stack(
        children: [
          (index == 3)
              ? Container()
              : const Positioned(
                  top: 80,
                  right: 0,
                  child: Image(
                    image: AssetImage("assets/material/Ellipse79.png"),
                  ),
                ),
          (index == 3)
              ? const Positioned(
                  bottom: -50,
                  right: 0,
                  child: Image(
                    image: AssetImage("assets/material/Ellipse79.png"),
                  ),
                )
              : Container(),
          SafeArea(
            child: (index == 3)
                ? AkunPage()
                : Container(
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: Consumer<ApiController>(
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
                                      api.getUser.isEmpty
                                          ? "Loading"
                                          : "${api.getUser[0].name} - ${api.getUser[0].kelas}",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                CircleAvatar(
                                  backgroundColor: colorGreen,
                                  radius: 23,
                                  backgroundImage: api.getUser.isNotEmpty
                                      ? NetworkImage(api.getUser[0].photoUrl)
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: width,
                            // padding: const EdgeInsets.only(
                            // top: 24,
                            // left: 20,
                            // right: 20,
                            // bottom: 10,
                            // ),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, -1),
                                  blurRadius: 5,
                                )
                              ],
                            ),
                            child: body[index],
                            // child: (index < 3) ? body[index] : Container(),
                            // child: SingleChildScrollView(
                            //   physics: AlwaysScrollableScrollPhysics(),
                            //   child: (index < 3) ? body[index] : null,
                            // ),
                            // child: Container(
                            //   padding: const EdgeInsets.only(
                            //     top: 24,
                            //   ),
                            //   child: (index < 3) ? body[index] : null,
                            // ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
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
