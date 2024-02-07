import 'package:flutter/material.dart';
import 'package:rp_projeto/src/screens/atividades_screen/atividades_screen.dart';
import 'package:rp_projeto/src/screens/esqueceu_senha_screen/esqueceu_senha_screen.dart';
import 'package:rp_projeto/src/screens/login_screen/login_screen.dart';
import 'package:rp_projeto/src/screens/meus_pontos_screen/meus_pontos_screen.dart';
import 'package:rp_projeto/src/screens/notificacao_expandida_screen/notificacao_expandida_screen.dart';
import 'package:rp_projeto/src/screens/notificacao_screen/notificacao_screen.dart';
import 'package:rp_projeto/src/screens/perfil_screen/perfil_screen.dart';
import 'package:rp_projeto/src/screens/suporte_screen/suporte_screen.dart';

class Routes {
  static const String telaLogin = 'TelaLogin';
  static const String telaEsqueceuSenha = 'TelaEsqueceuSenha';
  static const String telaAtividades = 'TelaAtividades';
  static const String telaMeusPontos = 'TelaMeusPontos';
  static const String telaPerfil = 'TelaPerfil';
  static const String telaNotificacao = 'TelaNotificacao';
  static const String telaNotificacaoExpandida = 'TelaNotificacaoExpandida';
  static const String telaSuporte= 'TelaSuporte';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      telaLogin: (context) => TelaLoginWidget(),
      telaEsqueceuSenha: (context) => TelaEsqueceuSenhaWidget(),
      telaAtividades: (context) => TelaAtividadesWidget(),
      telaMeusPontos: (context) => TelaMeusPontosWidget(),
      telaPerfil: (context) => TelaPerfilWidget(),
      telaNotificacao: (context) =>TelaNotificacaoWidget(),
      telaNotificacaoExpandida: (context) =>TelaNotificacaoExpandidaWidget(),
      telaSuporte: (context) => TelaSuporteWidget(),
      // Adicione mais rotas conforme necessário
    };
  }
}
