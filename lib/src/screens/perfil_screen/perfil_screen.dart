import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/firebase_utils.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../models/user_info.dart';

class TelaPerfilWidget extends StatefulWidget {
  const TelaPerfilWidget({Key? key}) : super(key: key);

  @override
  State<TelaPerfilWidget> createState() => _TelaPerfilWidgetState();
}

class _TelaPerfilWidgetState extends State<TelaPerfilWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentPageIndex = 2;
  late UserInformacoes _userInfo = UserInformacoes(nome: '', cpf: '', email: '', funcao: ''); // Inicialização com valores padrão

  @override
  void initState() {
    super.initState();
    // Iniciando o carregamento das informações do usuário ao inicializar o widget
    _loadUserInfo();
  }

  // Função para carregar informações do usuário
  Future<void> _loadUserInfo() async {
    UserInformacoes? userInfo = await getUserInfo();
    if (userInfo != null) {
      setState(() {
        _userInfo = userInfo;
      });
    } else {
      // Em caso de falha ao carregar as informações do usuário, exiba uma mensagem de erro
      showSnackBar(context, 'Falha ao carregar informações do usuário.');
    }
  }

  // Função para exibir uma Snackbar com uma mensagem de erro
  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFF236742),
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            // TITULO DA PAGINA ====================================================================
            Positioned(
              top: screenHeight * 0.05,
              left: 0,
              right: 0,
              child: const SizedBox(
                width: double.infinity,
                child: Text(
                  'Perfil',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // BACKGOUND BRANCO ====================================================================
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.83,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
            ),

            // FOTO DO USUARIO =====================================================================
            Positioned(
              top: screenHeight * 0.175,
              left: screenWidth * 0.5 - 60,
              child: Container(
                width: 120,
                height: 120,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/user_photo.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // BORDA AO REDOR DA FOTO =============================================================
            Positioned(
              top: screenHeight * 0.1737,
              left: screenWidth * 0.5 - 61.5,
              child: Container(
                width: 123,
                height: 123,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF236742),
                    width: 3,
                  ),
                ),
              ),
            ),

            // Icon Suporte =========================================================================
            Positioned(
              top: screenHeight * 0.18,
              right: screenWidth * 0.02,
              child: IconButton(
                onPressed: () {
                  Get.toNamed('/TelaSuporte');
                },
                icon: const Icon(
                  Icons.support_agent,
                  color: Color(0xFF236742),
                  size: 35,
                ),
              ),
            ),

            // Icon Notificação ======================================================================
            Positioned(
              top: screenHeight * 0.18,
              left: screenWidth * 0.02,
              child: IconButton(
                onPressed: () {
                  Get.toNamed('/TelaNotificacao');
                },
                icon: const Icon(
                  Icons.notifications_sharp,
                  color: Color(0xFF236742),
                  size: 35,
                ),
              ),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 170),
                  _userInfo != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Nome:', // LABEL NOME
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Skeletonizer(
                              enabled: _userInfo.nome.isEmpty, // Ativa o esqueleto se o nome do usuário estiver vazio
                              child: Container(
                                width: 370,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    _userInfo.nome.isNotEmpty ? _userInfo.nome : '________________________', 
                                    style: const TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              'Matrícula:', // LABEL MATRICULA
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Skeletonizer(
                              enabled: _userInfo.cpf.isEmpty, // Ativa o esqueleto se o CPF do usuário estiver vazio
                              child: Container(
                                width: 370,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    _userInfo.cpf.isNotEmpty ? _userInfo.cpf : '________________________', 
                                    style: const TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              'E-Mail:', // LABEL E-Mail
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Skeletonizer(
                              enabled: _userInfo.email.isEmpty, // Ativa o esqueleto se o e-mail do usuário estiver vazio
                              child: Container(
                                width: 370,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    _userInfo.email.isNotEmpty ? _userInfo.email : '________________________', 
                                    style: const TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              'Cargo:', // LABEL CARGO
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Skeletonizer(
                              enabled: _userInfo.funcao.isEmpty, // Ativa o esqueleto se a função do usuário estiver vazia
                              child: Container(
                                width: 370,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    _userInfo.funcao.isNotEmpty ? _userInfo.funcao : '________________________', 
                                    style: const TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : const CircularProgressIndicator(), // Exibe um indicador de carregamento enquanto as informações do usuário estão sendo carregadas
                ],
              ),
            ),


            // POSICAO DO MENU =======================================================================
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.1,
                decoration: const BoxDecoration(
                  color: Color(0xFF236742),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildMenuButton('TelaMeusPontos', Icons.menu_book_sharp, 'Meus Pontos', 1),
                    buildMenuButton('TelaAtividades', Icons.home, 'Atividades', 0),
                    buildMenuButton('TelaPerfil', Icons.person, 'Perfil', 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // CRIACAO DO MENU =============================================================================
  Widget buildMenuButton(String route, IconData icon, String label, int index) {
    return InkWell(
      onTap: () {
        Get.toNamed('/${route}');
        setState(() {
          _currentPageIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 100),
          Icon(
            icon,
            color: _currentPageIndex == index ? Colors.white : const Color(0x7FFFFFFF),
            size: 35,
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Roboto',
              color: _currentPageIndex == index ? Colors.white : const Color(0x7FFFFFFF),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
