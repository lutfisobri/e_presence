import 'package:e_presence/core/providers/pelajaran_provider.dart';
import 'package:e_presence/core/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/providers/init.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserControlProvider()),
        ChangeNotifierProvider(create: (_) => PelajaranProvider()),
      ],
      child: const Main(),
    ),
  );
}