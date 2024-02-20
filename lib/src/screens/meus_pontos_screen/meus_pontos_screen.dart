import 'package:flutter/material.dart';
import '../../utils/firebase_utils.dart';
import '../../models/registro_ponto.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TelaMeusPontosWidget extends StatefulWidget {
  const TelaMeusPontosWidget({Key? key}) : super(key: key);

  @override
  State<TelaMeusPontosWidget> createState() => _TelaMeusPontosWidgetState();
}

class _TelaMeusPontosWidgetState extends State<TelaMeusPontosWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentPageIndex = 1;
  List<RegistroPonto> _registrosPonto = []; // Lista para armazenar os registros de ponto
  bool _isLoading = true; // Estado para controlar o carregamento

  @override
  void initState() {
    super.initState();
    _carregarRegistrosPonto(); // Carregar os registros de ponto ao inicializar o widget
  }

  // Função para carregar os registros de ponto do colaborador atual
  Future<void> _carregarRegistrosPonto() async {
    try {
      // Obtendo os registros de ponto do colaborador
      List<RegistroPonto> registrosPonto = await getRegistrosPonto();
      setState(() {
        _registrosPonto = registrosPonto;
        _isLoading = false; // Atualiza o estado para indicar que o carregamento foi concluído
      });
      print('RegistrosPontos = ${_registrosPonto.toString()}');
    } catch (error) {
      // Em caso de erro, exibir uma mensagem de erro
      _showSnackBar('Erro ao carregar os registros de ponto: $error');
    }
  }

  // Função para exibir uma Snackbar com uma mensagem de erro
  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFF236742),
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            // TITULO DA PAGINA
            Positioned(
              top: screenHeight * 0.05,
              left: 0,
              right: 0,
              child: const SizedBox(
                width: double.infinity,
                child: Text(
                  'Meus Pontos',
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
            // FUNDO BRANCO
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.83,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: _isLoading
                    ? const Center(
                        child: SpinKitFadingFour(
                        color: Color(0xFF236742),
                        size: 50.0,
                      )
                    )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 40,),
                            // Lista de registros de ponto
                            for (var registroPonto in _registrosPonto) ...[
                              Center(
                                child: SizedBox(
                                  width: screenWidth * 0.75,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: const Color(0xFF236742), width: 3),
                                    ),
                                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Align(
                                          alignment: AlignmentDirectional(-0.8, -1),
                                          child: Text(
                                            registroPonto.nomeObra,
                                            style: const TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            const Align(
                                              alignment: AlignmentDirectional(-0.89, 0),
                                              child: Text(
                                                'Data:',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 1,
                                                    ),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(15.0),
                                                    child: Text(
                                                      '${registroPonto.horaRegistroPonto} - ${registroPonto.dataRegistroPonto}',
                                                      style: const TextStyle(
                                                        fontFamily: 'Readex Pro',
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 15),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            const Align(
                                              alignment: AlignmentDirectional(-0.89, 0),
                                              child: Text(
                                                'Status:',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 1,
                                                    ),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(15.0),
                                                    child: Text(
                                                      registroPonto.status,
                                                      style: const TextStyle(
                                                        fontFamily: 'Readex Pro',
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40,),
                            ],
                          ],
                        ),
                      ),
              ),
            ),
            // POSIÇÃO DO MENU
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.1,
                decoration: const BoxDecoration(
                  color: Color(0xFF236742),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildMenuButton('TelaMeusPontos', Icons.menu_book_sharp, 'Meus Pontos', 1),
                    buildMenuButton('TelaAtividades', Icons.home, 'Atividades', 0),
                    buildMenuButton('TelaPerfil', Icons.person, 'Perfil', 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //CRIACAO DO MENU
  Widget buildMenuButton(String route, IconData icon, String label, int index) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(route);
        setState(() {
          _currentPageIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 100),
          Icon(
            icon,
            color: _currentPageIndex == index ? Colors.white : const Color(0x7FFFFFFF),
            size: 35,
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Roboto',
              color: _currentPageIndex == index ? Colors.white : const Color(0x7FFFFFFF),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
