import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import 'app.dart';
import 'model/information.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(InformationAdapter());
  Hive.registerAdapter(ClientAdapter());
  Hive.registerAdapter(OptsAdapter());
  Hive.registerAdapter(UserAdapter());
  runApp(const ProviderScope(child: MyApp()));
}
