import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/firebase_auth_service.dart';
import '../../../firebase_options.dart';

class TelaLoginWidget extends StatefulWidget {
  const TelaLoginWidget({Key? key}) : super(key: key);

  @override
  _TelaLoginWidgetState createState() => _TelaLoginWidgetState();

}

class _TelaLoginWidgetState extends State<TelaLoginWidget> {
  late TextEditingController _emailController;
  late TextEditingController _senhaController;
  late FocusNode _textFieldFocusNode1;
  late FocusNode _textFieldFocusNode2;
  bool _passwordVisibility = false;
  FirebaseAuthService _auth = FirebaseAuthService();


  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _senhaController = TextEditingController();
    _textFieldFocusNode1 = FocusNode();
    _textFieldFocusNode2 = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    _textFieldFocusNode1.dispose();
    _textFieldFocusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;


    return GestureDetector(
      onTap: () {
        if (_textFieldFocusNode1.canRequestFocus ||
            _textFieldFocusNode2.canRequestFocus) {
          FocusScope.of(context).requestFocus(FocusNode());
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
                  // NOME E LOGO DO PROJETO =============================================================
                  Positioned(
                    top: screenHeight * 0.0,
                    left: 0,
                    right: 0,
                    child: Center(
                      // Centraliza verticalmente em relação ao Stack
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

              //FUNDO BRANCO ===================================================================
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

                  //NOME ENTRAR =======================================================================
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 15),
                        const Text(
                          'Entrar',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        //CAMPO EMAIL ==================================================================
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            const Align(
                              alignment: AlignmentDirectional(-0.70, -0.5),
                              child: Text(
                                'Email:',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 23,
                                ),
                              ),
                            ),
                            _buildTextField(
                              label: '',
                              controller: _emailController,
                              focusNode: _textFieldFocusNode1,
                            ),

                            //CAMPO SENHA ==================================================================
                            const SizedBox(height: 20),
                            const Align(
                              alignment: AlignmentDirectional(-0.70, -0.5),
                              child: Text(
                                'Senha:',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 23,
                                ),
                              ),
                            ),
                            _buildTextField(
                              label: '',
                              controller: _senhaController,
                              focusNode: _textFieldFocusNode2,
                              isPassword: true,
                              obscureText: !_passwordVisibility,
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    _passwordVisibility = !_passwordVisibility;
                                  });
                                },
                                child: Icon(
                                  _passwordVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  size: 22,
                                  color: const Color(0xFF236742),
                                ),
                              ),
                            ),
                          ],
                        ),

                        //ESQUECI MINHA SENHA ==========================================================
                        const SizedBox(height: 10),
                        Align(
                          alignment: const AlignmentDirectional(-0.70, 0.22),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, 'TelaEsqueceuSenha');
                            },
                            child: const Text(
                              'Esqueci minha senha',
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                color: Color(0xFF0808D3),
                                fontSize: 13,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),

                        //BOTAO ENTRAR ===================================================================
                        const SizedBox(
                          height: 47,
                        ),
                        ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0xFF236742),
                            fixedSize: const Size(250, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Entrar',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
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

  //CRIACAO DOS TEXTFIELD CAMPOS PARA O USARIO INSERIR O SEUS DADOS ==========================================

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    bool isPassword = false,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 15,
          ),
          errorStyle: const TextStyle(
            fontFamily: 'Roboto',
            color: Colors.red,
            fontSize: 20,
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
              color: Color(0xFF236742),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          suffixIcon: suffixIcon,
        ),
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 20,
        ),
      ),
    );
  }


  // void _login() async {
    
  //   String email = _emailController.text.trim();
  //   String senha = _senhaController.text.trim();

  //   User? user = await _auth.signInWithEmailAndPassword(email, senha);

  //   if (user != null){
  //     print('Usuário logado com sucesso!');
  //     Navigator.pushNamed(context, 'TelaAtividades');
  //   } else {
  //     print('Erro ao fazer login!');
  //   }

  // }

  void _login() async {
    String email = _emailController.text.trim();
    String senha = _senhaController.text.trim();

    User? user = await _auth.signInWithEmailAndPassword(email, senha);

    if (user != null){
      print('Usuário logado com sucesso!');
      Navigator.pushNamed(context, 'TelaAtividades');
    } else {
      print('Erro ao fazer login!');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro de Login'),
            content: Text('Senha ou email incorretos. Por favor, tente novamente.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
