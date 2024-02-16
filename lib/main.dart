import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rp_projeto/routes.dart';
import 'package:rp_projeto/src/screens/inicializacao_screen/inicializacao_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Solicitar permissões de câmera e microfone
  await _requestPermissions();
  
  runApp(MyApp());
}

Future<void> _requestPermissions() async {
  await Permission.camera.request();
  await Permission.microphone.request();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: Routes.getRoutes(),
      home: TelaInicializacaoWidget(),
    );
  }
}
