import 'package:cloud_firestore/cloud_firestore.dart';

//MANEJA PROCESOS DE ACTUALIZACION DE USUARIOS
class UpdateService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

//DE ACUERDO AL FLAG, SE AUMENTA EL NIVEL DE ACCESO O SE REDUCE
  Future<void> upgradeClearance(String uid, bool flag) async {
    try {
      if (flag == true) {
        await firestore.collection('Users').doc(uid).update({"clearance": 2});
      } else {
        await firestore.collection('Users').doc(uid).update({"clearance": 1});
      }
    } catch (e) {}
  }

  Future<void> deleteUser(String uid) async {
    try {
      await firestore.collection('Users').doc(uid).delete();
    } catch (e) {}
  }

//RETORNA LISTA DE DOCUMENTOS (ZONAS) A LAS QUE EL USUARIO QUE PROVEE UID PUEDE ACCEDER
  Future<List<DocumentSnapshot>> getAccessibleZones(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await firestore.collection('Users').doc(userId).get();
      int clearance = userDoc['clearance'];

      QuerySnapshot zonesSnapshot = await firestore
          .collection('Zones')
          .where('minClearance', isLessThanOrEqualTo: clearance)
          .get();

      return zonesSnapshot.docs;
    } catch (e) {
      return [];
    }
  }
}
