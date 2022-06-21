import 'package:flutter/material.dart';

import 'app.dart';
import 'core/singletons/local_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();

  runApp(const MyApp());
}
