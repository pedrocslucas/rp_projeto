import 'package:flutter/material.dart';
import 'package:rp_projeto/src/screens/esqueceu_senha_screen/esqueceu_senha_screen.dart';
import 'package:rp_projeto/src/screens/login_screen/login_screen.dart';

class Routes {
  static const String telaLogin = 'TelaLogin';
  static const String telaEsqueceuSenha = 'TelaEsqueceuSenha';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      telaLogin: (context) => TelaLoginWidget(),
      telaEsqueceuSenha: (context) => TelaEsqueceuSenhaWidget(),
      // Adicione mais rotas conforme necessário
    };
  }
}
