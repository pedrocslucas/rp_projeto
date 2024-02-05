import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart'; // Adicionando a importação necessária

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

    // On page load action.
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      Navigator.of(context).pushReplacementNamed('TelaLogin');
    });
  }

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
          child: Stack(
            children: [
              const Align(
                alignment: AlignmentDirectional(0, 0.04),
                child: Text(
                  'PointJob',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -0.27),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/icon-rp-projeto.png',
                    width: 153,
                    height: 141,
                    fit: BoxFit.contain,
                    alignment: const Alignment(0, 0),
                  ),
                ),
              ),
            ],
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
