import 'package:flutter/material.dart';

class TelaMeusPontosWidget extends StatefulWidget {
  const TelaMeusPontosWidget({Key? key}) : super(key: key);

  @override
  State<TelaMeusPontosWidget> createState() => _TelaMeusPontosWidgetState();
}

class _TelaMeusPontosWidgetState extends State<TelaMeusPontosWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentPageIndex = 1;

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

            //TITULO DA PAGINA =========================================================================
            Positioned(
              top: screenHeight * 0.05,
              left: 0,
              right: 0,
              child: const SizedBox(
                width: double.infinity,
                child: Text(
                  'Meus Pontos',
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
            
            //FUNDO BRANCO =============================================================================
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

            //MOSTRANDO OS PONTOS DOS TRABALHADORES =====================================================
            Positioned(
              bottom: screenHeight * 0.55,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: screenWidth * 0.75,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: const Color(0xFF236742), width: 3),
                    ),
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [

                        //NOME DA CONTRUTORA =======================================================
                        const Align(
                          alignment: AlignmentDirectional(-0.8, -1),
                          child: Text(
                            'ABC Construções',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        //LABEL DATA ========================================================================
                        const SizedBox(height: 15),
                         Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Align(
                              alignment: AlignmentDirectional(-0.89, 0),
                              child: Text(
                                'Data:',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 15,
                                ),
                              ),
                            ),

                            //CAMPO COM O VALOR DA DATA ==================================================
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text(
                                      '06/02/2024',
                                      style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        //LABEL STATUS =============================================================
                        const SizedBox(height: 15),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Align(
                              alignment: AlignmentDirectional(-0.89, 0),
                              child: Text(
                                'Status:',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 15,
                                ),
                              ),
                            ),

                          //CAMPO COM O VALOR DO STATUS ==================================================
                           Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text(
                                      'Confirmado',
                                      style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // POSIÇÃO DO MENU ===========================================================================
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

//CRIACAO DO MENU ==================================================================================
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