import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import'package:flutter_dotenv/flutter_dotenv.dart';

import './screens/chat_screen.dart';
import './screens/loading_screen.dart';
import './screens/error_screen.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot)  {
        if (snapshot.hasError) {
          return MaterialApp(
            title: 'Ag caint i nGleann Comhann',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: ErrorScreen(),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Ag caint i nGleann Comhann',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: ChatScreen(),
          );
        }
        return MaterialApp(
          title: 'Ag caint i nGleann Comhann',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: LoadingScreen(),
        );
      },
    );
  }
}
