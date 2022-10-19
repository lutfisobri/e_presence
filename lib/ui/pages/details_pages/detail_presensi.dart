import 'package:e_presence/core/providers/api_controller.dart';
import 'package:e_presence/core/providers/user_controller.dart';
import 'package:e_presence/ui/shared/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/model/model_presensi.dart';

class DetailPresensi extends StatefulWidget {
  const DetailPresensi({super.key});
  static const routeName = "/detailPresensi";

  @override
  State<DetailPresensi> createState() => _PresensiState();
}

class _PresensiState extends State<DetailPresensi> {
  ModelPresensi? _chose;

  List<ModelPresensi> items = [
    ModelPresensi("Hadir"),
    ModelPresensi("Izin"),
    ModelPresensi("Telat"),
  ];

  final styleThemeData = StyleThemeData();

  @override
  void initState() {
    super.initState();
    _chose = items[0];
  }

  double? distance;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserControlProvider>(context, listen: false);
    final args = ModalRoute.of(context)!.settings.arguments;
    int index = int.parse(args.toString()) - 1;
    user.subscription.onData((data) {
      setState(() {
        distance = Geolocator.distanceBetween(
          -8.124655,
          113.336256,
          data.latitude,
          data.longitude,
        );
      });
    });
    return WillPopScope(
      onWillPop: () async {
        user.reset();
        user.streamDispose();
        return true;
      },
      child: Scaffold(
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
                  child: Consumer<ApiController>(
                    builder: (context, value, child) => Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Mata Pelajaran"),
                            teks(
                              text: value.getJadwal[index].name,
                              fontWeight: FontWeight.bold,
                              size: 14,
                            ),
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
                                DateTime.parse(value.getJadwal[index].jam),
                              ),
                              fontWeight: FontWeight.bold,
                              size: 14,
                            ),
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
                                DateTime.parse(value.getJadwal[index].jam),
                              ),
                              fontWeight: FontWeight.bold,
                              size: 14,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const teks(text: "Status Area"),
                            teks(
                              text: distance == null
                                  ? "1000 meter"
                                  : "${distance!.round()} meter",
                              fontWeight: FontWeight.bold,
                              size: 14,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: styleThemeData.colorGreen,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: DropdownButton(
                            value: _chose,
                            items: items.map<DropdownMenuItem<ModelPresensi>>(
                              (e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Text(
                                          e.data,
                                          style: TextStyle(color: styleThemeData.colorGreen),
                                        ),
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
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: styleThemeData.colorGreen,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Consumer<UserControlProvider>(
                          builder: (context, user, child) => Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: styleThemeData.colorGreen),
                              borderRadius: BorderRadius.circular(11),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(11),
                              onTap: () {
                                user.pickImage();
                              },
                              child: user.source == null
                                  ? Container(
                                      height: 200,
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, bottom: 30),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Tambah Foto",
                                              style: TextStyle(
                                                color: styleThemeData.colorGreen,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Image.asset(
                                                "assets/image/foto.png"),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 200,
                                      width: double.infinity,
                                      child: Image.file(
                                        user.path,
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
                          UserControlProvider userAuth = UserControlProvider();
                          userAuth.verificationPresensi(
                            context,
                            distance!,
                            _chose!,
                            items,
                          );
                        },
                        // style: ButtonStyle(
                        //   backgroundColor:
                        //       MaterialStatePropertyAll<Color>(styleThemeData.colorGreen),
                        // ),
                        child: const Text("SIMPAN"),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            user.source = null;
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
