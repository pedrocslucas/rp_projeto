import 'package:flutter/material.dart';

class TelaNotificacaoWidget extends StatefulWidget {
  const TelaNotificacaoWidget({Key? key}) : super(key: key);

  @override
  State<TelaNotificacaoWidget> createState() => _TelaNotificacaoWidgetState();
}

class _TelaNotificacaoWidgetState extends State<TelaNotificacaoWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
                  'Notificações',
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

            //SETA PARA VOLTAR ==========================================================================
            Align(
              alignment: const AlignmentDirectional(-0.92, -0.87),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('TelaPerfil');
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 30,
                ),
                iconSize: 40,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),

            //BACKGROUD BRANCO ==========================================================================
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.85,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
            ),

            // BOTAO QUE MOSTRA AS NOTIFICACOES DO TRABALHADOR ======================================
            Positioned(
              bottom: screenHeight * 0.65,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: screenWidth * 0.75,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('TelaNotificacaoExpandida');
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: const BorderSide(color: Color(0xFF236742), width: 2),
                      ),
                      padding: const EdgeInsets.fromLTRB(36, 36, 36, 36),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_forward_ios, size: 20, color: Color(0xFF236742)),
                        SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            'NOTIF001 - Notificação 1', //VALOR DO CAMPO DO BOTAO
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis, // Adiciona reticências se o texto for muito longo
                            maxLines: 1, // Define o número máximo de linhas para 1
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
