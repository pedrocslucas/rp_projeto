// import 'package:flutter/material.dart';

// class TelaAtividadesWidget extends StatefulWidget {
//   const TelaAtividadesWidget({Key? key}) : super(key: key);

//   @override
//   State<TelaAtividadesWidget> createState() => _TelaAtividadesWidgetState();
// }

// class _TelaAtividadesWidgetState extends State<TelaAtividadesWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   int _currentPageIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: Color(0xFF236742),
//       body: SafeArea(
//         top: true,
//         child: Stack(
//           children: [
//             Positioned(
//               top: screenHeight * 0.05,
//               left: 0,
//               right: 0,
//               child: Container(
//                 width: double.infinity,
//                 child: const Text(
//                   'Atividades',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontFamily: 'Roboto',
//                     color: Colors.white,
//                     fontSize: 35,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               left: 0,
//               child: Container(
//                 width: screenWidth,
//                 height: screenHeight * 0.85,
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               left: 0,
//               child: Container(
//                 width: screenWidth,
//                 height: screenHeight * 0.1,
//                 decoration: const BoxDecoration(
//                   color: Color(0xFF236742),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(25),
//                     topRight: Radius.circular(25),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     buildMenuButton('TelaMeusPontos', Icons.menu_book_sharp, 'Meus Pontos', 1),
//                     buildMenuButton('TelaAtividades', Icons.home, 'Atividades', 0),
//                     buildMenuButton('TelaPerfil', Icons.person, 'Perfil', 2),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildMenuButton(String route, IconData icon, String label, int index) {
//     return InkWell(
//       onTap: () {
//         Navigator.of(context).pushNamed(route);
//         setState(() {
//           _currentPageIndex = index;
//         });
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Icon(
//             icon,
//             color: _currentPageIndex == index ? Colors.white : const Color(0x7FFFFFFF),
//             size: 35,
//           ),
//           Text(
//             label,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontFamily: 'Roboto',
//               color: _currentPageIndex == index ? Colors.white : const Color(0x7FFFFFFF),
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

