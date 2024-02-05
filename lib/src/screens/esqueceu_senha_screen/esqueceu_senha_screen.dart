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
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(75),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/icon-rp-projeto.png',
                        width: 220,
                        height: 93,
                        fit: BoxFit.contain,
                        alignment: Alignment(0, 0),
                      ),
                      const SizedBox(height: 1),
                      const Text(
                        'PointJob',
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 441,
                  height: 500,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
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
