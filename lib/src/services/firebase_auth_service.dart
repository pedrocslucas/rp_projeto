import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e, stackTrace) {
      // Tratar a exceção aqui
      print('Error: $e');
      print('StackTrace: $stackTrace');
      return null;
    }
  }
}
