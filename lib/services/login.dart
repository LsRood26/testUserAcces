import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//MANEJA TODA LA LOGICA DE AUTENTICACION - COMUNICACION DIRECTA CON FIREBASE AUTH
class LoginAuth {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<User?> signInEmailandPassword(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user not found') {
        return null;
      } else if (e.code == 'Wrong password') {
        return null;
      }
      return null;
    }
  }

  signOut() async {
    await auth.signOut();
  }

  Future<String?> signUp(
      String email, String password, String name, String lastName) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      String uid = userCredential.user!.uid;

      await firestore.collection('Users').doc(uid).set({
        "email": email,
        "isAdmin": false,
        "lastName": lastName,
        "name": name,
        "clearance": 1
      });

      return uid;
    } on FirebaseAuthException catch (e) {
      return null;
    }
  }
}
