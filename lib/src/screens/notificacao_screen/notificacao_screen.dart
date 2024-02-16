import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TelaNotificacaoWidget extends StatefulWidget {
  const TelaNotificacaoWidget({Key? key}) : super(key: key);

  @override
  State<TelaNotificacaoWidget> createState() => _TelaNotificacaoWidgetState();
}

class _TelaNotificacaoWidgetState extends State<TelaNotificacaoWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
            //TITULO DA PAGINA ====================================================================
            Positioned(
              top: screenHeight * 0.05,
              left: 0,
              right: 0,
              child: const SizedBox(
                width: double.infinity,
                child: Text(
                  'Notificações',
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

            //SETA PARA VOLTAR ==========================================================================
            Align(
              alignment: const AlignmentDirectional(-0.92, -0.87),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('TelaPerfil');
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

            //BACKGROUD BRANCO ==========================================================================
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Lista de Notificações',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('notificacao').snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                );
                              } else {
                                final notifications = snapshot.data!.docs;
                                return ListView.builder(
                                  itemCount: notifications.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final notification = notifications[index];
                                    final titulo = notification['titulo'] ?? '';
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pushNamed('TelaNotificacaoExpandida',
                                          arguments: notification.id);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.black,
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4),
                                            side: const BorderSide(color: Color(0xFF236742), width: 2),
                                          ),
                                          padding: const EdgeInsets.all(20),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.arrow_forward_ios, size: 20, color: Color(0xFF236742)),
                                            SizedBox(width: 8),
                                            Flexible(
                                              child: Text(
                                                titulo,
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            }
                          },
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
    );
  }
}
