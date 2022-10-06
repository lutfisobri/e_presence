import 'package:e_presence/View/auth/login1.dart';
import 'package:e_presence/View/child/change_password.dart';
import 'package:e_presence/View/child/edit_profile.dart';
import 'package:e_presence/controller/api_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AkunPage extends StatelessWidget {
  AkunPage({super.key});

  final Color colorGreen = Color.fromARGB(255, 114, 182, 108);

  @override
  Widget build(BuildContext context) {
    final api = Provider.of<ApiController>(context, listen: false);
    api.loadJadwal;
    api.postUser();
    return Container(
      padding: const EdgeInsets.all(15),
      child: Consumer<ApiController>(
        builder: (context, value, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              // isThreeLine: true,
              leading: CircleAvatar(
                backgroundColor: colorGreen,
                backgroundImage: api.getUser.isNotEmpty
                    ? NetworkImage(api.getUser[0].photoUrl)
                    : null,
              ),
              title: api.getUser.isNotEmpty
                  ? Text(
                      api.getUser[0].name,
                      style: const TextStyle(
                          fontSize: 15.7, fontWeight: FontWeight.bold),
                    )
                  : null,
              subtitle:
                  api.getUser.isNotEmpty ? Text(api.getUser[0].username) : null,
              trailing: api.getUser.isNotEmpty
                  ? GestureDetector(
                      child: const Icon(Icons.edit),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditProfile(),
                          ),
                        );
                      },
                    )
                  : null,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Akun",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              color: colorGreen,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(9))),
              child: InkWell(
                borderRadius: BorderRadius.circular(9),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePassword(),
                    ),
                  );
                },
                child: const ListTile(
                  leading: Icon(Icons.edit),
                  title: Text(
                    "Ubah Kata Sandi",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  iconColor: Colors.white,
                  textColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              color: colorGreen,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(9)),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(9),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginF(),
                    ),
                  );
                },
                child: const ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(
                    "Keluar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
