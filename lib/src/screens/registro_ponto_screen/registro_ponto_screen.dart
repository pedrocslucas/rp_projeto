import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../utils/firebase_utils.dart';

import '../../models/registro_do_ponto.dart';

class TelaRegistroPontoWidget extends StatefulWidget {
  const TelaRegistroPontoWidget({Key? key}) : super(key: key);

  @override
  State<TelaRegistroPontoWidget> createState() =>
      _TelaRegistroPontoWidgetState();
}

class _TelaRegistroPontoWidgetState extends State<TelaRegistroPontoWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentPageIndex = 2;
  RegistroDoPonto? registroPonto; //Declarando como nullabel

  @override
  void initState() {
    super.initState();
    _buscarRegistroPontoAtual();
  }

  Future<void> _buscarRegistroPontoAtual() async {
    try {
      registroPonto = await getRegistroPontoAtual();
      setState(() {}); // Atualizar a tela após obter os dados
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Erro ao buscar o registro de ponto: $error"),
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    // Verifica se registroPonto é null antes de usá-lo
    String nome = registroPonto?.nome ?? '';
    String cpf = registroPonto?.cpf ?? '';
    String localizacao = registroPonto?.localizacao ?? '';
    String hora = registroPonto?.hora ?? '';
    String funcao = registroPonto?.funcao ?? '';

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
                  'Registro de Ponto',
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

                // CAMPOS SOBRE O TRABALHADOR e CONSTRUTORA =======================================================
                child: Column(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const SizedBox(height: 20),
                          screenHeight <= 686
                              ? const SizedBox(height: 20)
                              : const SizedBox(height: 50),

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
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                nome, //VALOR DO CAMPO NOME
                                style: const TextStyle(
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
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                cpf, //VALOR DO CAMPO CPF
                                style: const TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Hora de Entrada:', //LABEL HORA
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
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                hora, //VALOR DO CAMPO HORA
                                style: const TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Localização:', //LABEL LOCALIZAÇÃO
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
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                localizacao,
                                //VALOR DO CAMPO ENDEREÇO
                                style: const TextStyle(
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
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                funcao, //VALOR DO CAMPO FUNÇÃO
                                style: const TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // BOTAO CONFIRMAR ============================================================
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'TelaAtividades');
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF236742),
                      fixedSize: const Size(250, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Confirmar',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  const SizedBox(
                      height: 20), // Ajuste esta altura conforme necessário
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
