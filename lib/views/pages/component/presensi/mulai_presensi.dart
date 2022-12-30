import 'package:app_presensi/app/providers/pelajaran.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MulaiPresensi extends StatelessWidget {
  const MulaiPresensi({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return Consumer<PelajaranProvider>(builder: (context, value, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Mulai",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            DateFormat("dd MMMM y - hh.mm", "id_ID").format(
              DateTime.parse(
                value.findPresensi(id: id).mulaiPresensi ??
                    DateTime.now().toString(),
              ),
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    });
  }
}
