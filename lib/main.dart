import 'package:app_presensi/app/providers/informasi.dart';
import 'package:app_presensi/app/providers/pelajaran.dart';
import 'package:app_presensi/app/providers/presensi.dart';
import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/utils/cache_manager.dart';
import 'package:app_presensi/views/start/init.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  Cache().getCache();
  await initializeDateFormatting('id_ID', null).then(
    (_) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => PelajaranProvider()),
          ChangeNotifierProvider(create: (_) => InformasiProvider()),
          ChangeNotifierProvider(create: (_) => PresensiProvider()),
        ],
        child: const Main(),
      ),
    ),
  );
}