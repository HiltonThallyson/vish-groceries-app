import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;
  FirebaseAuth get auth => _auth;

  AuthProvider() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  _getUser() {
    _user = _auth.currentUser;
    notifyListeners();
  }

  logout() async {
    await _auth.signOut().then((_) {
      _getUser();
    });
  }

  Future<void> registrar(String email, String password, String username) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        _getUser();

        await FirebaseAuth.instance.setLanguageCode("pt-BR");
        await user?.sendEmailVerification();
        await user?.updateDisplayName(username);
        await user?.reload().then((_) => _getUser());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já está cadastrado.');
      } else {
        throw AuthException('Verifique os valores inseridos.');
      }
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        _getUser();
        notifyListeners();
        return value;
      });
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      if (e.code == 'user-not-found') {
        throw AuthException('E-mail não encontrado.');
      } else if (e.code == 'invalid-email') {
        throw AuthException('E-mail inválido.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta.');
      } else {
        throw AuthException('Verifique os valores inseridos.');
      }
    }
  }
}
