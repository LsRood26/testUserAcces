import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> upgradeClearance(String uid, bool flag) async {
    try {
      if (flag == true) {
        await firestore.collection('Users').doc(uid).update({"clearance": 2});
        /* Fluttertoast.showToast(
          msg: 'Actualizacion realizada exitosamente',
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
        ); */
      } else {
        await firestore.collection('Users').doc(uid).update({"clearance": 1});
        /* Fluttertoast.showToast(
          msg: 'Actualizacion realizada exitosamente',
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
        ); */
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Hubo un error al actualizar los permisos',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
      );
      print('error al actualizar $e');
    }
  }

  Future<void> deleteUser(String uid) async {
    try {
      await firestore.collection('Users').doc(uid).delete();
      print('Usuario Eliminado');
    } catch (e) {
      print('Error al eliminar usuario $e');
    }
  }
}
