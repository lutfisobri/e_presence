import 'package:e_presence/View/child/edit_Profile.dart';
import 'package:e_presence/controller/API_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class akun_Page extends StatelessWidget {
  akun_Page({super.key});

  final Color colorGreen = Color.fromARGB(255, 114, 182, 108);

  @override
  Widget build(BuildContext context) {
    final api = Provider.of<API_controller>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(15),
      child: Consumer<API_controller>(
        builder: (context, value, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              // isThreeLine: true,
              leading: CircleAvatar(
                backgroundImage: NetworkImage(api.user[0].photoUrl),
              ),
              title: Text(api.user[0].name),
              subtitle: Text(api.user[0].username),
              trailing: GestureDetector(
                child: const Icon(Icons.edit),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => edit_Profile(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text("Akun"),
            const SizedBox(
              height: 20,
            ),
            Card(
              color: colorGreen,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: const ListTile(
                leading: Icon(Icons.edit),
                title: Text("Ubah Kata Sandi"),
                iconColor: Colors.white,
                textColor: Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              color: colorGreen,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: GestureDetector(
                onTap: () {},
                child: const ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Keluar"),
                  iconColor: Colors.white,
                  textColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
