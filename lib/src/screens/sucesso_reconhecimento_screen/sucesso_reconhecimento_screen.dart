import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TelaReconhecimentoSucessoWidget extends StatelessWidget {
  const TelaReconhecimentoSucessoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    }
    
//FUNDO BRANCO ========================================================================================================
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  //IMAGEM DO V ===================================================================================
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/V.jpg',
                      width: 300,
                      height: 242,
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    ),
                  ),

                  //TEXTO "PRONTO" =================================================================================
                  const SizedBox(height: 20),
                  const Text(
                    'Pronto!',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Color(0xFF236742),
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                //TEXTO DO SUCESSO DO REC... ======================================================================
                  const SizedBox(height: 20),
                  const Text(
                    'Seu reconhecimento facial\nfoi realizado com sucesso.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                    ),
                  ),

            //BOTAO DE COONFIRMAR ===========================================================================
                const SizedBox(height: 150),
               Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'TelaRegistroPonto');
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

            //ICONE DE X PARA FECHAR ===========================================================================
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pushNamed('TelaAtividades');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
