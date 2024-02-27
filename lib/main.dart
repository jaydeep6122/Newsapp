import 'package:flutter/material.dart';

import 'package:newsapp/model/Home_model.dart';
import 'package:newsapp/model/webview_model.dart';
import 'package:newsapp/screen/Home.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => newsCenter()),
        ChangeNotifierProvider(create: (context) => webview_model()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.light(),
            useMaterial3: true,
            brightness: Brightness.light),
        darkTheme: ThemeData(
            colorScheme: ColorScheme.dark(),
            useMaterial3: true,
            brightness: Brightness.dark),
        home: Home(),
      ),
    );
  }
}
