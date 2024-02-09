import 'package:flutter/material.dart';

class TelaSuporteWidget extends StatefulWidget {
  const TelaSuporteWidget({Key? key}) : super(key: key);

  @override
  State<TelaSuporteWidget> createState() => _TelaSuporteWidgetState();
}

class _TelaSuporteWidgetState extends State<TelaSuporteWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final maxLines = (screenHeight * 0.016).toInt();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFF236742),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView( 
          child: Container(
            height: screenHeight,
            child: Stack(
              children: [

                //TITULO DA JANELA =============================================================================
                Positioned(
                  top: screenHeight * 0.05,
                  left: 0,
                  right: 0,
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Suporte',
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

                //SETA DE VOLTAR ==================================================================================
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

                //FUNDO BRANCO ============================================================================
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

                //TEXTO ACIMA DO CAMPO ============================================================================
                Positioned(
                  top: screenHeight * 0.20,
                  left: 10,
                  right: 0,
                  child: const SizedBox(
                    width: double.infinity,
                    child: Align(
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        'Mande uma mensagem para nossa \nequipe relatando o seu problema:',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),

                //CAMPO PARA O USUARIO DIGITAR A MSG
                Align(
                  alignment: const AlignmentDirectional(0, 0.20),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: SizedBox(
                      width: 300,
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _textEditingController,
                          autofocus: true,
                          obscureText: false,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 15,
                            ),
                            hintStyle: const TextStyle(
                              fontFamily: 'Roboto',
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 15,
                          ),
                          maxLines: maxLines,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, digite sua mensagem.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),


                //POP UP DE MSG ENVIADA ==========================================================================
                Align(
                  alignment: const AlignmentDirectional(0, 0.90),
                  child: SizedBox(
                    width: 250,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: const Text('Mensagem enviada'),
                                content: const Text(
                                  'A sua mensagem foi enviada para nossa equipe, e será analisada.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(alertDialogContext);
                                      _textEditingController.clear();
                                    },
                                    child: const Text('Ok'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },

                      //BOTAO DE ENVIAR =============================================================
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF236742),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Enviar',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
