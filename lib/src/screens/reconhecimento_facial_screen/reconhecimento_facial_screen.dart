import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';

class TelaReconhecimentoFacialWidget extends StatefulWidget {
  const TelaReconhecimentoFacialWidget({Key? key}) : super(key: key);

  @override
  State<TelaReconhecimentoFacialWidget> createState() => _TelaReconhecimentoFacialWidgetState();
}

class _TelaReconhecimentoFacialWidgetState extends State<TelaReconhecimentoFacialWidget> {
  late CameraController _controller;

//SE FOR RODAR O CODIGO NO PC (WEB) USAR ESSE CODIGO =================================================

// @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     final cameras = await availableCameras();
//     if (cameras.isEmpty) {
//       // Caso não haja câmeras disponíveis, você pode tratar isso aqui
//       print('Nenhuma câmera encontrada.');
//       return;
//     }
//     final firstCamera = cameras.first;
//     _controller = CameraController(firstCamera, ResolutionPreset.medium);
//     await _controller.initialize();
//     if (mounted) {
//       setState(() {});
//     }
//   }
//// ATE AQUI O DO PC WEB^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



////SE FOR RODAR O CODIGO NO CELULAR USAR ESSE CODIGO =================================================
@override
void initState() {
  super.initState();
  _initializeCamera();
}

Future<void> _initializeCamera() async {
  final cameras = await availableCameras();
  CameraDescription? frontCamera; // Mudança aqui

  for (final camera in cameras) {
    if (camera.lensDirection == CameraLensDirection.front) { // Mudança aqui
      frontCamera = camera; // Mudança aqui
      break;
    }
  }

  if (frontCamera == null) {
    throw CameraException('Câmera frontal não encontrada.', 'cameraNotFound'); // Mudança aqui
  }

  _controller = CameraController(frontCamera, ResolutionPreset.medium); // Mudança aqui
  await _controller.initialize();
  if (mounted) {
    setState(() {});
  }
}
//// ATE AQUI O DO CELULAR ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    if (_controller == null || !_controller.value.isInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF236742),
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            // Seu código existente para o background branco
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: screenWidth,
                height: screenHeight > 855 ? screenHeight * 0.79 : screenHeight * 0.77, 
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
            ),
            // Câmera integrada dentro do background branco
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox( // Aqui você pode ajustar a altura do Container
                height: screenHeight > 855  ? screenHeight * 0.80 : screenHeight * 0.78, 
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: CameraPreview(_controller),
                ),
              ),
              ),
            ),
            Center(
              child: CustomPaint(
                size: Size(screenWidth, screenHeight),
                painter: OvalPainter(),
              ),
            ),
             
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/TelaReconhecimentoSucesso');
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
            // Seu código existente para o título e outros elementos
            Positioned(
              top: screenHeight * 0.02,
              left: 0,
              right: 0,
              child: const SizedBox(
                width: double.infinity,
                child: Text(
                  'Centralize o rosto\n na moldura',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-0.92, -0.90),
              child: IconButton(
                onPressed: () {
                  Get.toNamed('/TelaInfoConstrucao');
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
            
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class OvalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF236742)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final horizontalRadius = size.width * 0.7; // Ajuste o raio horizontal conforme necessário
    final verticalRadius = size.height * 0.5; // Ajuste o raio vertical conforme necessário

    canvas.drawOval(
      Rect.fromCenter(center: size.center(Offset.zero), width: horizontalRadius, height: verticalRadius),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
