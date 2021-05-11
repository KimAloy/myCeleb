import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myceleb/provider/requests_provider.dart';
import 'package:myceleb/screens/screens.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ChangeNotifierProvider(
      create: (context) => RequestsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          scaffoldBackgroundColor: Colors.white,
          // primarySwatch: Colors.green,
        ),
        home: CelebritiesScreen(),
        // home: MyFanRequestsScreen(),
      ),
    );
  }
}
