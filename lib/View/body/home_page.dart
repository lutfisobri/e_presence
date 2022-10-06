import 'package:e_presence/View/child/detail_presensi.dart';
import 'package:e_presence/controller/api_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({
    Key? key,
  }) : super(key: key);

  _refreshJadwal(ApiController api) async {
    await Future.delayed(
      Duration(seconds: 1),
    );
    api.loadJadwal();
    api.postUser();
  }

  final Color colorGreen = Color.fromARGB(255, 114, 182, 108);
  final Color textColor = Color.fromARGB(255, 87, 87, 87);

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    var time = DateFormat('EEEE, d MMMM y').format(date);
    final api = Provider.of<ApiController>(context, listen: false);
    api.loadJadwal;
    api.postUser();
    return Padding(
      padding: const EdgeInsets.only(top: 26),
      child: RefreshIndicator(
        onRefresh: () {
          return _refreshJadwal(api);
        },
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(
                // top: 24,
                left: 20,
                right: 20,
                bottom: 16,
              ),
              child: Consumer<ApiController>(
                builder: (context, value, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hari ini",
                          style: TextStyle(
                            fontSize: 19,
                            color: textColor,
                          ),
                        ),
                        Text(
                          time,
                          style: TextStyle(
                            fontSize: 15,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    value.getJadwal.isEmpty
                        ? Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "Yeay, tidak ada mata pelajaran",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.separated(
                            separatorBuilder: (context, index) => Container(
                              height: 16,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: value.getJadwal.length,
                            itemBuilder: (context, index) {
                              var dateTime =
                                  DateTime.parse(value.getJadwal[index].jam);
                              // return ListTile(
                              //   leading: CircleAvatar(
                              //     backgroundImage: NetworkImage(user.getJadwal[index].logo),
                              //   ),
                              //   title: Text(user.getJadwal[index].name,),
                              //   subtitle: Text(DateFormat('hh.mm - hh.mm').format(dateTime)),
                              // );
                              return Container(
                                height: 70,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      // color: colorGreen,
                                      offset: Offset(0, 8),
                                      blurRadius: 20,
                                    ),
                                  ],
                                  // color: colorGreen,
                                  borderRadius: BorderRadius.circular(11),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, DetailPresensi.routeName,
                                        arguments: value.getJadwal[index].id);
                                  },
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(11),
                                    child: Image(
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          value.getJadwal[index].logo),
                                    ),
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        value.getJadwal[index].name,
                                        style: const TextStyle(
                                            // color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      // const SizedBox(
                                      //   height: 1,
                                      // ),
                                      Text(
                                        DateFormat('hh.mm - hh.mm')
                                            .format(dateTime),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                        ),
                                        // style: const TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
