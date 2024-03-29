import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TelaReconhecimentoFalhaWidget extends StatelessWidget {
  const TelaReconhecimentoFalhaWidget({Key? key}) : super(key: key);

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
//BACKGROUND BRANCO =================================================================================================
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  //IMAGEM DO X =============================================================================
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/X.jpg',
                      width: 300,
                      height: 242,
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    ),
                  ),

                  //NOME ERRO =======================================================================================
                  const SizedBox(height: 20),
                  const Text(
                    'Erro!',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Color(0xFF236742),
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //TEXTO DA FALHA NO RECONHECIMENTO ================================================================
                  const SizedBox(height: 20),
                  const Text(
                    'Seu reconhecimento facial\n falhou, tente novamente.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                    ),
                  ),

              //BOTAO TENTAR NOVAMENTE ==============================================================================
              const SizedBox(height: 150),
               Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Get.toNamed( '/TelaReconhecimentoFacial');
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
                            'Tentar Novamente',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
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
            
            //SETA DE VOLTAR =========================================================================================
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Get.toNamed('/TelaInfoConstrucao');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
