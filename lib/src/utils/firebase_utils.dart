import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../models/user_info.dart';
import '../models/registro_do_ponto.dart';
import '../models/registro_ponto.dart';
import '../models/obra_info.dart';

// Função para obter os nomes e IDs das obras associadas ao usuário logado
Future<List<Map<String, String>>> getObrasDoUsuario() async {
  final User? user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    // Retorna uma lista vazia se o usuário não estiver logado
    return [];
  }

  String uid = user.uid;

  try {
    // Consulta para obter o documento de colaborador com base no UID do usuário logado
    QuerySnapshot colaboradorSnapshot = await FirebaseFirestore.instance
        .collection('colaborador')
        .where('uid', isEqualTo: uid)
        .limit(1) // Limita a consulta a 1 documento
        .get();

    if (colaboradorSnapshot.docs.isEmpty) {
      // Se não encontrar nenhum documento de colaborador com o UID do usuário, retorna uma lista vazia
      return [];
    }

    // Obtém o ID do documento de colaborador
    String colaboradorID = colaboradorSnapshot.docs.first.id;

    // Consulta para obter os documentos de obra_colaborador com base no ID do documento de colaborador
    QuerySnapshot obraColaboradorSnapshot = await FirebaseFirestore.instance
        .collection('obra_colaborador')
        .where('colaborador', isEqualTo: colaboradorID)
        .get();

    // Lista para armazenar os nomes e IDs das obras
    List<Map<String, String>> obras = [];

    // Itera sobre os documentos de obra_colaborador para obter os nomes e IDs das obras
    for (QueryDocumentSnapshot doc in obraColaboradorSnapshot.docs) {
      String obraID = doc['obra'] as String;

      // Consulta para obter o documento de obra com base no ID da obra
      DocumentSnapshot obraSnapshot = await FirebaseFirestore.instance.collection('obra').doc(obraID).get();
      
      // Adiciona o nome e o ID da obra à lista
      obras.add({
        'nome': obraSnapshot['nome'] as String,
        'id': obraID,
      });
    }

    return obras;
  } catch (error) {
    // Em caso de erro, imprime o erro e retorna uma lista vazia
    print("Erro ao obter obras do usuário: $error");
    return [];
  }
}

// OTHER FUNCTION ==================================================================================

//Função para obter as informações para "TelaInfoConstrucao"
Future<InformacoesObra> carregarInformacoesObra(String obraId) async {
  try {
    // Obtenha o documento da obra com base no ID fornecido
    var obraSnapshot = await FirebaseFirestore.instance.collection('obra').doc(obraId).get();

    // Obtenha os detalhes da obra
    String identificacao = obraSnapshot['nome'] ?? '';

    // Obtenha o ID da empresa contratante da obra
    String empresaContratanteId = obraSnapshot['empresa_contratante'];

    // Obtenha o documento da empresa contratante
    var empresaContratanteSnapshot = await FirebaseFirestore.instance.collection('empresa_contratante').doc(empresaContratanteId).get();

    // Obtenha os detalhes da empresa contratante
    String construtora = empresaContratanteSnapshot['nome'] ?? '';
    String cnpj = empresaContratanteSnapshot['cnpj'] ?? '';

    // Crie um objeto InformacoesObra com os detalhes obtidos
    var informacoesObra = InformacoesObra(
      identificacao: identificacao,
      construtora: construtora,
      cnpj: cnpj,
    );

    print("INFORMACOES OBRA = ${informacoesObra.toString()}");
    // Retorne as informações da obra
    return informacoesObra;
  } catch (error) {
    // Em caso de erro, imprima o erro e lance uma exceção
    print("Erro ao carregar informações da obra: $error");
    throw Exception('Erro ao carregar informações da obra.');
  }
}

// OTHER FUNCTION ==================================================================================

//Função para obter as informações do usuário para a tela de 'TelaPerfil'
Future<UserInformacoes?> getUserInfo() async {
  try {
    // Obtendo o usuário atualmente autenticado
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Obtendo o UID do usuário atual
      String uid = user.uid;

      // Consultando o Firestore para obter detalhes do colaborador com base no UID
      QuerySnapshot colaboradorSnapshot = await FirebaseFirestore.instance
        .collection('colaborador')
        .where('uid', isEqualTo: uid)
        .limit(1) // Limita a consulta a 1 documento
        .get();

      DocumentSnapshot userDoc;

      if (colaboradorSnapshot.docs.isNotEmpty) {
        // Se encontrar algum documento de colaborador com o UID fornecido, obtenha o primeiro documento
        userDoc = colaboradorSnapshot.docs.first;
      } else {
        // Se não encontrar nenhum documento de colaborador com o UID fornecido, retorne null
        return null;
      }

      // Verificando se o documento do colaborador existe
      if (userDoc.exists) {
        // Obtendo os dados do documento
        String nome = userDoc.get('nome') ?? '';
        String cpf = userDoc.get('cpf') ?? '';
        String email = userDoc.get('email') ?? '';
        String funcaoId = userDoc.get('funcao') ?? '';

        // Consultando o Firestore para obter o nome da função com base no ID da função
        DocumentSnapshot funcaoDoc = await FirebaseFirestore.instance.collection('funcoes_colaborador').doc(funcaoId).get();
        String funcaoNome = funcaoDoc.get('nome') ?? '';

        // Criando um objeto UserInfo com os dados obtidos
        UserInformacoes userInfo = UserInformacoes(
          nome: nome,
          cpf: cpf,
          email: email,
          funcao: funcaoNome,
        );

        // Retornando o objeto UserInfo
        return userInfo;
      } else {
        // Se o documento do colaborador não existir, retorne null
        return null;
      }
    } else {
      // Se o usuário não estiver autenticado, retorne null
      return null;
    }
  } catch (error) {
    // Em caso de erro, imprima o erro e retorne null
    print("Erro ao obter informações do usuário: $error");
    return null;
  }
}

// OTHER FUNCTION ==================================================================================

//Função para obter as informações referentes ao registro de ponto do colaborador.
Future<List<RegistroPonto>> getRegistrosPonto() async {
  try {
    // Obtendo o usuário atualmente autenticado
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Se o usuário não estiver autenticado, lançar uma exceção
      throw Exception('Usuário não autenticado.');
    }

    String uid = user.uid;
    print('UID do usuário: $uid');

    // Consultando o Firestore para obter o documento do colaborador com base no UID
    QuerySnapshot colaboradorSnapshot = await FirebaseFirestore.instance
        .collection('colaborador')
        .where('uid', isEqualTo: uid)
        .limit(1)
        .get();

    if (colaboradorSnapshot.docs.isEmpty) {
      // Se não houver documento de colaborador com o UID fornecido, retornar uma lista vazia
      return [];
    }

    // Obtendo o ID do documento do colaborador
    String colaboradorId = colaboradorSnapshot.docs.first.id;

    // Consultando o Firestore para obter os registros de ponto do colaborador com base no ID do colaborador
    QuerySnapshot registrosPontoSnapshot = await FirebaseFirestore.instance
        .collection('registros_pontos')
        .where('colaborador', isEqualTo: colaboradorId)
        .get();

    // Mapeando os documentos encontrados para objetos RegistroPonto
    List<RegistroPonto> registrosPonto = [];

    for (DocumentSnapshot doc in registrosPontoSnapshot.docs) {
      String obraId = doc.get('obra');
      String status = doc.get('status') ?? '';

      // Consultando o Firestore para obter o nome da obra com base no ID da obra
      DocumentSnapshot obraSnapshot = await FirebaseFirestore.instance
          .collection('obra')
          .doc(obraId)
          .get();

      String nomeObra = obraSnapshot.get('nome') ?? '';
      String horaRegistroPonto = doc.get('hora_registro_ponto') ?? '';
      String dataRegistroPonto = doc.get('data_registro_ponto') ?? '';

      // Criando um objeto RegistroPonto com os dados obtidos e adicionando à lista
      RegistroPonto registroPonto = RegistroPonto(
        nomeObra: nomeObra,
        horaRegistroPonto: horaRegistroPonto,
        dataRegistroPonto: dataRegistroPonto,
        status: status,
      );
      registrosPonto.add(registroPonto);
    }

    // Retornando a lista de objetos RegistroPonto
    print('RegistrosPonto = ${registrosPonto.toString()}');
    return registrosPonto;
  } catch (error) {
    // Em caso de erro, lançar uma exceção
    print("Erro ao obter registros de ponto do colaborador: $error");
    throw Exception('Erro ao obter registros de ponto do colaborador.');
  }
}

// OTHER FUNCTION ==================================================================================

//Função para enviar a mensagem 'feedback' do usuário para o suporte do sistema.
Future<void> enviarFeedbackPorEmail(String feedback) async {
  try {
    // Obtendo o usuário atualmente autenticado
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Se o usuário não estiver autenticado, lançar uma exceção
      throw Exception('Usuário não autenticado.');
    }

    // Obtendo o email do usuário logado
    String userEmail = user.email ?? '';

    // Configurações do servidor SMTP
    final smtpServer = gmail('email@gmail.com', 'senha');

    // Criando a mensagem de email
    final message = Message()
      ..from = Address('email@gmail.com', 'Sua Equipe de Suporte')
      ..recipients.add('pedrocslucas.dev@gmail.com') // Email para onde será enviado o feedback
      ..subject = 'Feedback do Usuário'
      ..text = 'Feedback do usuário $userEmail:\n\n$feedback';

    // Enviando o email
    final sendReport = await send(message, smtpServer);

    print('Email enviado: ${sendReport.toString()}');
  } catch (error) {
    // Em caso de erro, imprima o erro
    print("Erro ao enviar o feedback por email: $error");
    throw Exception('Erro ao enviar o feedback por email.');
  }
}

// OTHER FUNCTION ==================================================================================

//Função para obter os dados do registro de ponto do colaborador.
Future<RegistroDoPonto> getRegistroPontoAtual() async {
  try {
    // Obtendo o usuário atualmente autenticado
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Se o usuário não estiver autenticado, lançar uma exceção
      throw Exception('Usuário não autenticado.');
    }

    // Obtendo o UID do usuário atual
    String uid = user.uid;

    // Consultando o Firestore para obter os dados do colaborador com base no UID
    QuerySnapshot colaboradorSnapshot = await FirebaseFirestore.instance
        .collection('colaborador')
        .where('uid', isEqualTo: uid)
        .limit(1)
        .get();

    // Verificando se foi encontrado algum documento de colaborador
    if (colaboradorSnapshot.docs.isEmpty) {
      throw Exception('Documento de colaborador não encontrado.');
    }

    // Obtendo os dados do colaborador
    DocumentSnapshot colaboradorDoc = colaboradorSnapshot.docs.first;
    String nomeColaborador = colaboradorDoc.get('nome') ?? '';
    String cpfColaborador = colaboradorDoc.get('cpf') ?? '';
    String funcaoId = colaboradorDoc.get('funcao') ?? '';

    // Consultando a collection 'funcoes_colaborador' para obter o nome da função com base no ID
    DocumentSnapshot funcaoSnapshot = await FirebaseFirestore.instance
        .collection('funcoes_colaborador')
        .doc(funcaoId)
        .get();

    // Verificando se foi encontrada a função
    if (!funcaoSnapshot.exists) {
      throw Exception('Função do colaborador não encontrada.');
    }

    // Obtendo o nome da função
    String nomeFuncao = funcaoSnapshot.get('nome') ?? '';

    // Obtendo a localização atual do usuário
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Obtendo o endereço correspondente às coordenadas
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String enderecoAtual = placemarks.isNotEmpty
        ? placemarks.first.street ?? 'Endereço não encontrado'
        : 'Endereço não encontrado';

    // Obtendo a hora atual do sistema
    String horaAtual =
        DateFormat('HH:mm:ss').format(DateTime.now());

    // Criando e retornando o objeto RegistroDoPonto
    return RegistroDoPonto(
      nome: nomeColaborador,
      cpf: cpfColaborador,
      localizacao: enderecoAtual,
      hora: horaAtual,
      funcao: nomeFuncao,
    );
  } catch (error) {
    // Em caso de erro, lançar uma exceção
    print("Erro ao obter registro de ponto atual: $error");
    throw Exception('Erro ao obter registro de ponto atual.');
  }
}
