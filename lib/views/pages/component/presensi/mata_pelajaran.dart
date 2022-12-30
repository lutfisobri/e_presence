import 'package:app_presensi/app/providers/pelajaran.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MataPelajaran extends StatelessWidget {
  const MataPelajaran({
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
            "Mata Pelajaran",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value.findPresensi(id: id).namaMapel ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    });
  }
}
