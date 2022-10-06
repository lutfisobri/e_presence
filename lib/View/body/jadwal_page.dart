import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../controller/api_controller.dart';

class JadwalPage extends StatelessWidget {
  const JadwalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final api = Provider.of<ApiController>(context, listen: false);
    api.loadJadwal;
    api.postUser();
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("data"),
        ],
      ),
    );
  }
}
