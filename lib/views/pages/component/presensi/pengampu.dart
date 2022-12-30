import 'package:app_presensi/app/providers/pelajaran.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Pengampu extends StatelessWidget {
  const Pengampu({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Consumer<PelajaranProvider>(
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Pengampu",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              value.findPresensi(id: id).guru ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      },
    );
  }
}
