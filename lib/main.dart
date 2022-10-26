import 'package:e_presence/core/providers/api_controller.dart';
import 'package:e_presence/core/providers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/providers/init.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApiController()),
        ChangeNotifierProvider(create: (_) => UserControlProvider()),
      ],
      child: const Main(),
    ),
  );
}