import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Models/database.dart';
import 'Views/Pages/sora_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await QuranDB.initializeDatabase();
  runApp(MaterialApp(
    home: Directionality(
      textDirection: TextDirection.rtl,
        child: SoraScreen()),
  ));
}
