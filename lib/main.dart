import 'package:flutter/material.dart';
import 'package:rp_projeto/src/screens/esqueceu_senha_screen/esqueceu_senha_screen.dart';
import 'package:rp_projeto/src/screens/login_screen/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      

      title: 'Minha App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      routes: {
        'TelaLogin': (context) => TelaLoginWidget(),
        'TelaEsqueceuSenha': (context) => TelaEsqueceuSenhaWidget(),
      },
      
      home: TelaLoginWidget(),// Aqui você instancia e define a tela de login como a tela inicial
    );
  }
}
