import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_useracces/services/updates.dart';

class UserDetailPage extends StatefulWidget {
  UserDetailPage({super.key, required this.userData, required this.uid});
  final Map<String, dynamic> userData;
  final String uid;

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  final db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    UpdateService update = UpdateService();
    bool flag;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del usuario'),
      ),
      body: Container(
        width: size.width * 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Nombres Completos',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: size.height * 0.02),
            ),
            Text(
              '${widget.userData['name']} ${widget.userData['lastName']}',
              style: TextStyle(fontSize: size.height * 0.02),
            ),
            //Text('Apellido: ${widget.userData['lastName'] ?? 'No disponible'}'),
            Text('Correo Electronico',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: size.height * 0.02)),
            //Text('Correo: ${widget.userData['email'] ?? 'No disponible'}'),
            Text('${widget.userData['email']}',
                style: TextStyle(fontSize: size.height * 0.02)),
            Text('Nivel de acceso actual',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: size.height * 0.02)),
            Text('${widget.userData['clearance']}'),
            if (widget.userData['clearance'] == 1) ...[
              Container(
                child: TextButton(
                    onPressed: () async {
                      flag = true;
                      await update.upgradeClearance(widget.uid, flag);
                      Navigator.pop(context);
                    },
                    child: Text('Aumentar nivel de acceso 2')),
              ),
            ],
            if (widget.userData['clearance'] != 1) ...[
              Container(
                child: TextButton(
                    onPressed: () async {
                      flag = false;
                      await update.upgradeClearance(widget.uid, flag);
                      Navigator.pop(context);
                    },
                    child: Text('Disminuir nivel de acceso')),
              ),
            ],
            FloatingActionButton(
              onPressed: () async {
                await update.deleteUser(widget.uid);
                Navigator.pop(context);
              },
              child: Icon(Icons.delete),
            ),
            //Text('Eliminar Usuario?'),
            /* IconButton(
                onPressed: () async{
                  
                },
                icon: const Icon(Icons.delete)), */
          ],
        ),
      ),
    );
  }
}

Widget userDetails(String tag, String data) {
  return Column(
    children: [],
  );
}
