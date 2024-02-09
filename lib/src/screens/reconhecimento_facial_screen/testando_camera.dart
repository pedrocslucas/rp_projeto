import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class TelaReconhecimentoFacialWidget extends StatefulWidget {
  const TelaReconhecimentoFacialWidget({Key? key}) : super(key: key);

  @override
  State<TelaReconhecimentoFacialWidget> createState() =>
      _TelaReconhecimentoFacialWidgetState();
}

class _TelaReconhecimentoFacialWidgetState
    extends State<TelaReconhecimentoFacialWidget> {
  late CameraController _cameraController;
  Future<void>? _initializeControllerFuture;

 @override
void initState() {
  super.initState();
  _initializeControllerFuture = _initializeCamera();
}

Future<void> _initializeCamera() async {
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  _cameraController = CameraController(
    firstCamera,
    ResolutionPreset.medium,
  );

  return _cameraController.initialize();
}

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    //FUNDO VERDE //////////////////////////////////////////////////////////////////////////
    return Scaffold(
      backgroundColor: const Color(0xFF236742),
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: screenWidth,
                height: screenHeight > 855
                    ? screenHeight * 0.86
                    : screenHeight * 0.84,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        height: screenHeight > 855
                            ? screenHeight * 0.86
                            : screenHeight * 0.84,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: AspectRatio(
                            aspectRatio: _cameraController.value.aspectRatio,
                            child: ClipRect(
                              child: OverflowBox(
                                alignment: Alignment.bottomCenter,
                                maxHeight: double.infinity,
                                maxWidth: double.infinity,
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: SizedBox(
                                    width: screenWidth,
                                    height: screenHeight > 855
                                        ? screenHeight * 0.86
                                        : screenHeight * 0.84,
                                    child: CameraPreview(_cameraController),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),

            Center(
              child: CustomPaint(
                size: Size(screenWidth, screenHeight),
                painter: _OvalPainter(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('TelaLoadingReconhecimento');
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
                  const SizedBox(height: 20),
                ],
              ),
            ),
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
                    fontSize: 31,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-0.92, -0.90),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('TelaInfoConstrucao');
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
}

class _OvalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF236742)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final horizontalRadius = size.width * 0.7; 
    final verticalRadius = size.height * 0.5; 

    canvas.drawOval(
      Rect.fromCenter(
          center: size.center(Offset.zero),
          width: horizontalRadius,
          height: verticalRadius),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

