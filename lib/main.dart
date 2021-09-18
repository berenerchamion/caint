import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './screens/chat_screen.dart';
import './screens/loading_screen.dart';
import './screens/error_screen.dart';
import './screens/auth_screen.dart';

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
  ThemeData configureTheme(BuildContext ctx) {
    ThemeData ourTheme = ThemeData(
      primarySwatch: Colors.purple,
      colorScheme: ColorScheme.fromSwatch(
        backgroundColor: Colors.purple,
        primarySwatch: Colors.purple,
        accentColor: Colors.orange,
        brightness: Brightness.dark,
      ),
      buttonTheme: ButtonTheme.of(ctx).copyWith(
        buttonColor: Colors.deepPurple,
      ),
    );
    return ourTheme;
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    final ThemeData ourTheme = configureTheme(context);
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            title: 'Ag caint i nGleann Comhann',
            theme: ourTheme,
            home: ErrorScreen(),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Ag caint i nGleann Comhann',
            theme: ourTheme,
            home: AuthScreen(),
          );
        }
        return MaterialApp(
          title: 'Ag caint i nGleann Comhann',
          theme: ourTheme,
          home: LoadingScreen(),
        );
      },
    );
  }
}
