import 'package:app_presensi/app/providers/informasi.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailInformasi extends StatefulWidget {
  const DetailInformasi({Key? key}) : super(key: key);

  @override
  _DetailInformasiState createState() => _DetailInformasiState();
}

class _DetailInformasiState extends State<DetailInformasi> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<InformasiProvider>(context, listen: false).getData();
      setState(() {
        isLoading = false;
      });
    });
  }

  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments.toString();
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            foregroundColor: Colors.black,
            title: const Text("Detail Informasi"),
            centerTitle: false,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 263,
                  child: Consumer<InformasiProvider>(
                      builder: (context, value, child) {
                    return Center(
                      child: value.find(args).image == null
                          ? Image(
                              image: AssetImage(
                                  'assets/image/icondefaultinformasi.png'),
                            )
                          : CachedNetworkImage(
                              imageUrl: value.find(args).image!),
                    );
                  }),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 19, right: 19),
                  decoration: const BoxDecoration(),
                  child: Consumer<InformasiProvider>(
                      builder: (context, value, child) {
                    return Text(
                      value.find(args).desc,
                      style: TextStyle(
                        color: Color.fromRGBO(25, 61, 40, 1),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 242, right: 19, top: 67),
                  decoration: const BoxDecoration(),
                  child: Consumer<InformasiProvider>(
                      builder: (context, value, child) {
                    return Text(
                      value.find(args).updatedAt,
                      style: TextStyle(
                        color: Color.fromRGBO(25, 61, 40, 1),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        if (isLoading)
          Container(
            alignment: Alignment.center,
            color: Colors.white.withOpacity(0.3),
            child: const Center(
              child: SizedBox(
                height: 75,
                width: 75,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            ),
          )
      ],
    );
  }
}
