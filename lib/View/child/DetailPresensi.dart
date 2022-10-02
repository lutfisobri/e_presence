import 'package:e_presence/controller/API_controller.dart';
import 'package:e_presence/controller/User_Auth.dart';
import 'package:e_presence/controller/User_Location.dart';
import 'package:e_presence/controller/User_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Model/modelPresensi.dart';

class DetailPresensi extends StatefulWidget {
  const DetailPresensi({super.key});
  static const routeName = "/detailPresensi";

  @override
  State<DetailPresensi> createState() => _PresensiState();
}

class _PresensiState extends State<DetailPresensi> {
  late modelPresensi? _chose;

  List<modelPresensi> items = [
    modelPresensi("Hadir"),
    modelPresensi("Izin"),
    modelPresensi("Telat"),
  ];

  Color colorGreen = const Color.fromARGB(255, 114, 182, 108);

  @override
  void initState() {
    super.initState();
    _chose = items[0];
  }

  UserLocation userLocation = UserLocation();
  stopServices() {
    final berhenti = userLocation.setPosition();
    berhenti.stop();
  }

  @override
  void dispose() {
    stopServices();
    print("dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mapel = Provider.of<API_controller>(context, listen: false);
    final maps = Provider.of<UserLocation>(context, listen: false);
    final user = Provider.of<UserAuth>(context, listen: false);
    maps.setPosition();
    final pickPhoto = Provider.of<userImage>(context, listen: false);
    final args = ModalRoute.of(context)!.settings.arguments;
    int index = int.parse(args.toString()) - 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text("Presensi"),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Consumer<API_controller>(
                  builder: (context, value, child) => Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Mata Pelajaran"),
                          teks(text: mapel.jadwal[index].name),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Mulai"),
                          teks(
                              text: DateFormat('dd MMMM yyyy - hh.mm').format(
                                  DateTime.parse(mapel.jadwal[index].jam))),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Selesai"),
                          teks(
                              text: DateFormat('dd MMMM yyyy - hh.mm').format(
                                  DateTime.parse(mapel.jadwal[index].jam))),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<UserLocation>(
                        builder: (context, value, child) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const teks(text: "Status Area"),
                            teks(
                                text: maps.distance == null
                                    ? "0 meter"
                                    : "${maps.jarak.round()} meter"),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: colorGreen,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: DropdownButton(
                          value: _chose,
                          items: items.map<DropdownMenuItem<modelPresensi>>(
                            (e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(e.data),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ).toList(),
                          onChanged: (value) {
                            setState(() {
                              _chose = value;
                            });
                          },
                          underline: Container(),
                          isExpanded: true,
                          icon: Container(
                            padding: const EdgeInsets.only(right: 20),
                            child: const Icon(Icons.arrow_drop_down),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<userImage>(
                        builder: (context, value, child) => Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(11),
                            onTap: () {
                              pickPhoto.pickImage();
                            },
                            child: pickPhoto.source == null
                                ? Container(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, bottom: 30),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text("Tambah Foto"),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Image.asset("assets/image/foto.png"),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 200,
                                    width: double.infinity,
                                    child: Image.file(
                                      pickPhoto.path,
                                      // scale: 5,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Container(
                      //   padding: const EdgeInsets.only(
                      //       left: 25, right: 25, top: 10, bottom: 10),
                      //   decoration: BoxDecoration(
                      //     border: Border.all(color: colorGreen),
                      //     borderRadius: BorderRadius.circular(11),
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: const [
                      //       Text("Photo"),
                      //       Icon(Icons.check),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        UserAuth userAuth = UserAuth();
                        userAuth.verificationPresensi(context, pickPhoto, maps);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(colorGreen),
                      ),
                      child: const Text("SIMPAN"),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    width: double.infinity,
                    child: OutlinedButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStatePropertyAll<Color>(colorGreen)),
                      onPressed: () {
                        setState(() {
                          pickPhoto.source = null;
                          _chose = items[0];
                        });
                      },
                      child: const Text("RESET ULANG"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class teks extends StatelessWidget {
  const teks({
    Key? key,
    required this.text,
    this.size,
    this.fontWeight,
    this.color,
  }) : super(key: key);

  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: size,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
