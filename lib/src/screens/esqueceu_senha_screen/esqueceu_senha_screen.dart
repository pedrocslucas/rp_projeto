import 'package:flutter/material.dart';

class TelaEsqueceuSenhaWidget extends StatefulWidget {
  const TelaEsqueceuSenhaWidget({Key? key}) : super(key: key);

  @override
  _TelaEsqueceuSenhaWidgetState createState() =>
      _TelaEsqueceuSenhaWidgetState();
}

class _TelaEsqueceuSenhaWidgetState extends State<TelaEsqueceuSenhaWidget> {
  late FocusNode _emailFocusNode;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        if (_emailFocusNode.canRequestFocus) {
          FocusScope.of(context).requestFocus(_emailFocusNode);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF236742),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Stack(
                children: [
                  Positioned(
                    top: screenHeight * 0.0,
                    left: 0,
                    right: 0,
                    child: Center( // Centraliza verticalmente em relação ao Stack
                      child: Padding(
                        padding: const EdgeInsets.all(75),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/icon-rp-projeto.png',
                              width: 220,
                              height: 93,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 1), // Espaço entre a imagem e o texto
                            const Text(
                              'PointJob',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: screenWidth,
                  height: screenHeight * 0.65,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 70),
                        const Text(
                          'Esqueceu Senha',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 23),
                        const Text(
                          'Se você esqueceu sua senha\n'
                          'envie uma solicitação para a\n'
                          'administração que eles enviarão\n'
                          'sua nova senha no e-mail.',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 50),
                        ElevatedButton(
                          onPressed: () {
                            // Adicione aqui a lógica para enviar a solicitação
                            // e exibir o diálogo de confirmação.
                            _showDialog(context);
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
                            'Enviar',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 25,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            Navigator.pushNamed(context, 'TelaLogin');
                          },
                          child: const Text(
                            'Voltar para Login',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF0808D3),
                              fontSize: 15,
                              decoration: TextDecoration.underline,
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
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (alertDialogContext) {
        return AlertDialog(
          title: const Text('Solicitação Enviada'),
          content: const Text('Sua solicitação foi enviada para nossa equipe.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(alertDialogContext),
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}


 