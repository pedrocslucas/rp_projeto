import 'package:flutter/material.dart';

class TelaPerfilWidget extends StatefulWidget {
  const TelaPerfilWidget({Key? key}) : super(key: key);

  @override
  State<TelaPerfilWidget> createState() => _TelaPerfilWidgetState();
}

class _TelaPerfilWidgetState extends State<TelaPerfilWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentPageIndex = 2;

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

            //TITULO DA PAGINA ====================================================================
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

            

            //BACKGOUND BRANCO ========================================================================
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
            
            
            // FOTO DO USUARIO=============================================================================
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

            // BORDA AO REDOR DA FOTO==================================================================
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
              right: screenWidth *0.02,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('TelaSuporte');
                },
                icon: const Icon(
                  Icons.support_agent,
                  color: Color(0xFF236742),
                  size: 35,
                ),
              ),
            ),

            //Icon Notificação=======================================================================
            Positioned(
              top: screenHeight * 0.18,
              left: screenWidth *0.02,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('TelaNotificacao');
                },
                icon: const Icon(
                  Icons.notifications_sharp,
                  color: Color(0xFF236742),
                  size: 35,
                ),
              ),
            ),

            // CAMPOS SOBRE O TRABALHADOR ============================================================
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 170), 
                  const Text(
                    'Nome:', //LABEL NOME
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 5), 
                  Container(
                    width: 370,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'José Raimundo', //VALOR DO CAMPO NOME
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          fontSize: 17,
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
                  Container(
                    width: 370,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        '123.456.789-00', //VALOR DO CAMPO MATRICULA
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15), 
                  const Text(
                    'Cidade:', //LABEL CIDADE
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 5), 
                  Container(
                    width: 370,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'São Luís', //VALOR DO CAMPO CIDADE
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Cargo:', //LABEL CARGO
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 5), 
                  Container(
                    width: 370,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'Pedreiro', //VALOR DO CAMPO CARGO
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //POSICAO DO MENU ===========================================================================
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

  // CRIACAO DO MENU ======================================================================================
  Widget buildMenuButton(String route, IconData icon, String label, int index) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(route);
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

