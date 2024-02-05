import 'package:flutter/material.dart';
import 'package:rp_projeto/routes.dart';
import 'package:rp_projeto/src/screens/inicializacao_screen/inicializacao_screen.dart';


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
      routes: Routes.getRoutes(),
      home: TelaInicializacaoWidget(),
    );
  }
}
