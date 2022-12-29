import 'package:app_presensi/app/providers/informasi.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InformasiAkademik extends StatelessWidget {
  const InformasiAkademik({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 177,
      child: Consumer<InformasiProvider>(builder: (context, informasi, child) {
        return ListView.separated(
          separatorBuilder: (context, index) => Container(
            width: 14,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: informasi.informasi.length,
          shrinkWrap: true,
          padding:
              const EdgeInsets.only(left: 19, right: 19, top: 8, bottom: 8),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/detailInformasi",
                  arguments: informasi.informasi[index].id);
            },
            child: Container(
              width: 246,
              height: 119,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0XFF909090).withOpacity(0.08),
                      offset: const Offset(1, 2),
                      blurRadius: 2,
                    ),
                    BoxShadow(
                      color: const Color(0XFF909090).withOpacity(0.20),
                      offset: const Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ]),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 12.6, right: 12.6, top: 4),
                      width: 246,
                      height: 90,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3.15),
                        child: informasi.informasi[index].image == null ||
                                informasi.informasi[index].image == ""
                            ? Image.asset(
                                "assets/image/icondefaultinformasi.png",
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                imageUrl: informasi.informasi[index].image!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 12, right: 12, top: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            informasi.informasi[index].judul ?? "",
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0XFF193D28),
                              overflow: TextOverflow.visible,
                              fontFamily: "Roboto",
                            ),
                          ),
                          Text(
                            informasi.informasi[index].createdAt ?? "",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0XFF193D28),
                              fontFamily: "Roboto",
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
