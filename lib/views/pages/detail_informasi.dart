import 'package:flutter/material.dart';

class DetailInformasi extends StatefulWidget {
  const DetailInformasi({Key? key}) : super(key: key);

  @override
  _DetailInformasiState createState() => _DetailInformasiState();
}

class _DetailInformasiState extends State<DetailInformasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        elevation: 0,
        foregroundColor: Color.fromRGBO(0, 0, 0, 1),
        title: const Text('Detail Informasi',
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 263,
              child: const Center(
                child: Image(
                    image: AssetImage('assets/image/icondefaultinformasi.png')),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 19, right: 19),
              decoration: const BoxDecoration(),
              child: const Text(
                'Ujian Tengah Semester Ganjil Akan segera dilaksanakan Minggu depan. Jadi untuk siswa yang masih belum melunaskan uang ujian untuk segera di lunaskan.',
                style: TextStyle(
                  color: Color.fromRGBO(25, 61, 40, 1),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 242, right: 19, top: 67),
              decoration: const BoxDecoration(),
              child: const Text(
                'Maret 8 2023',
                style: TextStyle(
                  color: Color.fromRGBO(25, 61, 40, 1),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
