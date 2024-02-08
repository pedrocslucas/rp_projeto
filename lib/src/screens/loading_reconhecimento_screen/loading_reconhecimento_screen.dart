import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TelaLoadingReconhecimentoWidget extends StatefulWidget {
  const TelaLoadingReconhecimentoWidget({Key? key}) : super(key: key);

  @override
  State<TelaLoadingReconhecimentoWidget> createState() =>
      _TelaLoadingReconhecimentoWidgetState();
}

class _TelaLoadingReconhecimentoWidgetState
    extends State<TelaLoadingReconhecimentoWidget> {
  late FocusNode _unfocusNode;

  @override
  void initState() {
    super.initState();
    _unfocusNode = FocusNode();

    // On page load action.
    SchedulerBinding.instance!.addPostFrameCallback((_) async {});
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          top: true,
          child: Container(
            color: Colors.white, // Define a cor de fundo do último plano como branco
            child: Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(0.83, -0.95),
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 40,
                    ),
                    onPressed: () async {
                      Navigator.of(context).pushNamed('TelaInfoConstrucao');
                    },
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0, -0.4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/load.png',
                      width: 300,
                      height: 242,
                      fit: BoxFit.contain,
                      alignment: const Alignment(0, 0),
                    ),
                  ),
                ),

                
                Align(
                  alignment: const AlignmentDirectional(0, 0.100),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                    child: Container(
                      width: 250,
                      height: 15,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: const LinearProgressIndicator(
                          value: 0.9,
                          backgroundColor: Colors.black,
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF339660)),
                        ),
                      ),
                    ),
                  ),
                ),

                Align(
                  alignment: const AlignmentDirectional(0, 1.15),
                  child: Container(
                    width: double.infinity,
                    height: 168,
                    decoration: const BoxDecoration(
                      color: Color(0xFF236742),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: const Align(
                      alignment: AlignmentDirectional(0, -0.2),
                      child: Text(
                        'Analisando Foto...',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
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
