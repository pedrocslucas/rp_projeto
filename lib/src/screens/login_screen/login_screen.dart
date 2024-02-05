import 'package:flutter/material.dart';


class TelaLoginWidget extends StatefulWidget {
  const TelaLoginWidget({Key? key}) : super(key: key);

  @override
  _TelaLoginWidgetState createState() => _TelaLoginWidgetState();
}

class _TelaLoginWidgetState extends State<TelaLoginWidget> {
  late TextEditingController _textController1;
  late TextEditingController _textController2;
  late FocusNode _textFieldFocusNode1;
  late FocusNode _textFieldFocusNode2;
  bool _passwordVisibility = false;

  @override
  void initState() {
    super.initState();
    _textController1 = TextEditingController();
    _textController2 = TextEditingController();
    _textFieldFocusNode1 = FocusNode();
    _textFieldFocusNode2 = FocusNode();
  }

  @override
  void dispose() {
    _textController1.dispose();
    _textController2.dispose();
    _textFieldFocusNode1.dispose();
    _textFieldFocusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      ),
                      const SizedBox(height: 1), // Espaço entre a imagem e o texto
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
                        const SizedBox(height: 15),
                        const Text(
                          'Entrar',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            const Align(
                              alignment: AlignmentDirectional(-0.88, -0.5),
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
                              controller: _textController1,
                              focusNode: _textFieldFocusNode1,
                            ),
                            const SizedBox(height: 20),
                            const Align(
                              alignment: AlignmentDirectional(-0.88, -0.5),
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
                              controller: _textController2,
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
                                ),
                              ),
                            ),
                          ],
                        ),

                        Align(
                           alignment: const AlignmentDirectional(-0.83, 0.22),
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
                        const SizedBox(height: 47,),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'TelaAtividades');
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: const Color(0xFF236742),
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

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    bool isPassword = false,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
}
