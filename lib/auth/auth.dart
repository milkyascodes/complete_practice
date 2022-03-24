import 'package:firebase_auth/firebase_auth.dart';

abstract class RootAuth {
  Future signInWithEmailAndPassword(email, password);
  Future createUserWithEmailAndPassword(email, password);
  Future currentUser();
  Future signOutUser();
}

class Auth implements RootAuth {
  final FirebaseAuth firebase = FirebaseAuth.instance;

  @override
  Future signInWithEmailAndPassword(email, password) async {
    var user = await firebase.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user!.email;
  }

  @override
  Future createUserWithEmailAndPassword(email, password) async {
    var user = await firebase.createUserWithEmailAndPassword(
        email: email, password: password);
    return user.user!.email;
  }

  @override
  Future currentUser() async {
    var user = await firebase.currentUser;
    return user!.email;
  }

  @override
  Future signOutUser() {
    return firebase.signOut();
  }
}
