import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart'; 

class TelaInicializacaoWidget extends StatefulWidget {
  const TelaInicializacaoWidget({Key? key}) : super(key: key);

  @override
  _TelaInicializacaoWidgetState createState() =>
      _TelaInicializacaoWidgetState();
}

class _TelaInicializacaoWidgetState extends State<TelaInicializacaoWidget> {
  late TelaInicializacaoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = TelaInicializacaoModel();
    //_redirectToLogin();

    // On page load action.
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      Get.toNamed('/TelaLogin');
    });
  }

  /*void _redirectToLogin() {
    // Navegar para a tela de login usando Get
    Future.delayed(Duration.zero, () {
      Get.offNamed('TelaLogin'); // Usando Get para navegar para a tela de login
    });
  }*/

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFF236742),
        body: SafeArea(
          top: true,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/icon-rp-projeto.png',
                    width: 153,
                    height: 141,
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'PointJob',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
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

class TelaInicializacaoModel {
  /// State fields for stateful widgets in this page.
  final unfocusNode = FocusNode();

  /// Initialization and disposal methods.
  void dispose() {
    unfocusNode.dispose();
  }
}
