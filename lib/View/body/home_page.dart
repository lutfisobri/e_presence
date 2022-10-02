import 'package:e_presence/View/child/DetailPresensi.dart';
import 'package:e_presence/controller/API_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({
    Key? key,
  }) : super(key: key);

  _refreshJadwal(API_controller api) async {
    await Future.delayed(
      Duration(seconds: 1),
    );
    // await api.clearJadwal();
    await api.loadJadwal();
  }

  final Color colorGreen = Color.fromARGB(255, 114, 182, 108);

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    var time = DateFormat('EEEE, d MMMM y').format(date);
    final user = Provider.of<API_controller>(context, listen: false);
    return Consumer<API_controller>(
      builder: (context, value, child) => RefreshIndicator(
        onRefresh: () {
          return _refreshJadwal(user);
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 10,
          ),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Hari ini",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    time,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              user.jadwal.isEmpty
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.7,
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
                      separatorBuilder: (context, index) => Divider(),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: user.jadwal.length,
                      itemBuilder: (context, index) {
                        var dateTime = DateTime.parse(user.jadwal[index].jam);
                        return Container(
                          height: 70,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: colorGreen,
                              borderRadius: BorderRadius.circular(11)),
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, DetailPresensi.routeName,
                                  arguments: user.jadwal[index].id);
                            },
                            leading: Image(
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                              image: NetworkImage(user.jadwal[index].logo),
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  user.jadwal[index].name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  DateFormat('hh.mm - hh.mm').format(dateTime),
                                  style: const TextStyle(color: Colors.white),
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
    );
  }
}
