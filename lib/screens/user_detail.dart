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
            userDetails(
                'Nombres Completos',
                '${widget.userData['name']} ${widget.userData['lastName']}',
                size),
            userDetails(
                'Correo Electronico', '${widget.userData['email']}', size),
            userDetails('Nivel de acceso actual',
                '${widget.userData['clearance']}', size),
            if (widget.userData['clearance'] == 1) ...[
              GestureDetector(
                onTap: () async {
                  flag = true;
                  await update.upgradeClearance(widget.uid, flag);
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.purple.shade100,
                      borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.all(12),
                  child: Text('Aumentar el nivel de acceso'),
                ),
              ),
            ],
            if (widget.userData['clearance'] != 1) ...[
              GestureDetector(
                onTap: () async {
                  flag = false;
                  await update.upgradeClearance(widget.uid, flag);
                  Navigator.pop(context);
                },
                child: Container(
                  child: Text('Disminuir el nivel de acceso'),
                ),
              ),
            ],
            FloatingActionButton(
              onPressed: () async {
                await update.deleteUser(widget.uid);
                Navigator.pop(context);
              },
              child: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}

Widget userDetails(String tag, String data, Size size) {
  return Column(
    children: [
      Text(
        tag,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: size.height * 0.02),
      ),
      Text(data, style: TextStyle(fontSize: size.height * 0.02)),
    ],
  );
}
