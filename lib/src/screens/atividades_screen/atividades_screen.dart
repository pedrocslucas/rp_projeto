import 'package:flutter/material.dart';
import '../../services/firebase_utils.dart';

class TelaAtividadesWidget extends StatefulWidget {
  const TelaAtividadesWidget({Key? key}) : super(key: key);

  @override
  State<TelaAtividadesWidget> createState() => _TelaAtividadesWidgetState();
}

class _TelaAtividadesWidgetState extends State<TelaAtividadesWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentPageIndex = 0;

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
            // TITULO DA PAGINA =========================================================================
            Positioned(
              top: screenHeight * 0.05,
              left: 0,
              right: 0,
              child: const SizedBox(
                width: double.infinity,
                child: Text(
                  'Atividades',
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

            //FUNDO BRANCO ================================================================================
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

            // BOTAO QUE MOSTRA AS ATIVIDADES DO TRABALHADOR ==================================================
            Positioned(
              bottom: screenHeight * 0.65,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: screenWidth * 0.75,
                  child: FutureBuilder<List<Map<String, String>>>(
                    future: getObrasDoUsuario(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text("Erro: ${snapshot.error}");
                      } else {
                        List<Map<String, String>> obras = snapshot.data ?? [];
                        if (obras.isEmpty) {
                          return Center(
                            child: Text(
                              "Você aparentemente não pertence a nenhuma obra atualmente.",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Roboto',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        } else {
                          return Column(
                            children: obras.map((obra) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('TelaInfoConstrucao', arguments: obra['id']);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      side: BorderSide(color: Color(0xFF236742), width: 2),
                                    ),
                                    padding: EdgeInsets.fromLTRB(36, 36, 36, 36),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.arrow_forward_ios, size: 20, color: Color(0xFF236742)),
                                      SizedBox(width: 8),
                                      Flexible(
                                        child: Text(
                                          obra['nome'].toString(),
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
            ),

            // POSICAO DO MENU ==============================================================================
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

  //CONSTRUÇÃO DO MENU =========================================================================================
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
