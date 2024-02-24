import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:rp_projeto/src/utils/controllers.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../utils/firebase_utils.dart';
import '../../models/obra_info.dart';

class TelaInfoConstrucaoWidget extends StatefulWidget {

  const TelaInfoConstrucaoWidget({Key? key}) : super(key: key);

  @override
  State<TelaInfoConstrucaoWidget> createState() =>
      _TelaInfoConstrucaoWidgetState();
}

class _TelaInfoConstrucaoWidgetState extends State<TelaInfoConstrucaoWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late InformacoesObra informacoesObra = InformacoesObra(
    identificacao: '',
    construtora: '',
    cnpj: '',
  );

  @override
  void initState() {
    super.didChangeDependencies();
    Get.put(ObraController()); // Inicialize o ObraController
    // Inicializando a carregando informações da obra
    // Agendar a chamada para carregarInfoObra após o initState ser concluído
    Future.delayed(Duration.zero, () {
      carregarInfoObra();
    });
  }

  Future<void> carregarInfoObra() async {
    try {
      // Recebe o ID do documento da obra da tela anterior
      final String obraId = Get.find<ObraController>().obraId; // Obtenha o ID da obra

      // Carregar informações da obra
      InformacoesObra loadInfoObra = await carregarInformacoesObra(obraId);

      print("INFOOBRA = ${loadInfoObra.toString()}");

      setState(() {
        // Atualizar o estado com as informações carregadas
        informacoesObra = loadInfoObra;
      });
    } catch (error) {
      // Em caso de erro, imprima o erro
      print("Erro ao carregar informações da obra: $error");
    }
  }

  Widget _buildMapWidget() {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(51.509364, -0.128928),
        initialZoom: 15.5,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        const CircleLayer(
        circles: [
          CircleMarker(
            point: LatLng(51.509364, -0.128928),
            radius: 100,
            useRadiusInMeter: true,
            color: Color.fromARGB(109, 54, 57, 244) 
          ),
        ],
      ),
        const MarkerLayer(
          markers: [
            Marker(
              point: LatLng(51.509364, -0.128928),
              width: 80,
              height: 80,
              child: Icon(
                Icons.location_on,
                color: Colors.red,
                size: 40.0,
              ),
            ),
          ],
        ),
        
      ],
    );
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
            // TITULO DA PAGINA ====================================================================
            Positioned(
              top: screenHeight * 0.05,
              left: 0,
              right: 0,
              child: const SizedBox(
                width: double.infinity,
                child: Text(
                  'Construção',
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

            // SETA PARA VOLTAR ==========================================================================
            Align(
              alignment: const AlignmentDirectional(-0.92, -0.87),
              child: IconButton(
                onPressed: () {
                  Get.toNamed('/TelaAtividades');
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

            // BACKGROUD BRANCO ==========================================================================
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

                //TODOS OS CAMPOS DA CONSTRUCAO ==============================================================
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //CAMPO IDENTIFICACAO =================================================================
                        const SizedBox(height: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Identificação:',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Skeletonizer(
                              enabled: informacoesObra.identificacao.isEmpty,
                              child: Container(
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text(
                                    informacoesObra.identificacao.isNotEmpty ? informacoesObra.identificacao : '________________________',
                                    style: const TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        //CAMPO CONSTRUTORA =================================================================
                        const SizedBox(height: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Construtora:',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Skeletonizer(
                              enabled: informacoesObra.construtora.isEmpty,
                              child: Container(
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text(
                                    informacoesObra.construtora.isNotEmpty ? informacoesObra.construtora : '________________________',
                                    style: const TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        //CAMPO CNPJ =================================================================
                        const SizedBox(height: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'CNPJ:',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Skeletonizer(
                              enabled: informacoesObra.cnpj.isEmpty,
                              child: Container(
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text(
                                     informacoesObra.cnpj.isNotEmpty ? informacoesObra.cnpj : '________________________',
                                    style: const TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        //CAMPO ENTRADA =================================================================
                        const SizedBox(height: 15),
                        // Você pode adicionar os demais campos aqui

                        //LOCALIZACAO ========================================================================
                        const SizedBox(height: 15),
                         Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Localização:',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              height: 200,
                              child: _buildMapWidget(), // Use o MapWidget aqui
                            ),
                          ],
                        ),


                        //BOTAO DE REALIZAR O PONTO =================================================
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () {
                            Get.toNamed('/TelaReconhecimentoFacial');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF236742),
                            padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          child: const Text(
                            'Realizar Ponto',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
