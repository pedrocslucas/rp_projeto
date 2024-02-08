import 'package:flutter/material.dart';

class TelaNotificacaoExpandidaWidget extends StatefulWidget {
  const TelaNotificacaoExpandidaWidget({Key? key}) : super(key: key);

  @override
  State<TelaNotificacaoExpandidaWidget> createState() => _TelaNotificacaoExpandidaWidgetState();
}

class _TelaNotificacaoExpandidaWidgetState extends State<TelaNotificacaoExpandidaWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

     //BACKGROUND VERDE ===================================================================
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFF236742),
      body: SafeArea(
        top: true,
        child: Stack(
          children: [

            //TITULO DA PAGINA ==========================================================================
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
                  Navigator.of(context).pushNamed('TelaNotificacao');
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

            //BACKGROUND BRANCO ===================================================================
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
              
              //TITULO DA NOTIFICAÇÃO===================================================================
                child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        const Text(
                          'Aviso de Manutenção',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

              // MENSAGEM ===============================================================================
                        const SizedBox(height: 23), 
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25), 
                              child: Text(
                                'Informamos que amanhã - sexta-feira (21/04), entre as 08h e 12h, será realizada uma atualização na configuração do servidor de e-mail da universidade, por este motivo, comunicamos que na data e horário supracitados, o serviço de e-mail estará temporariamente indisponível.\n\nCaso haja alguma dúvida, favor entrar em contato com o STi através da página www.sistemas.univasf.edu.br/suporte ou do telefone: 87-2101-6809.\n\nPedimos desculpas pelos possíveis transtornos e agradecemos a compreensão de todos!'
                                ,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),

                // BOTAO VOLTAR =========================================================================
                        const SizedBox(height: 70),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('TelaNotificacao');
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0xFF236742),
                            fixedSize: const Size(215, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            'Voltar',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ],
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