import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_useracces/services/login.dart';
import 'package:test_useracces/screens/user_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Future<Map<String, dynamic>> userData;
  final log = LoginAuth();

  Stream<QuerySnapshot> fetchNonAdminUsers() {
    return firestore
        .collection('Users')
        .where('isAdmin', isEqualTo: false)
        .snapshots();
  }

  @override
  void initState() {
    super.initState();
    userData = fetchUserData();
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    final String? uid = auth.currentUser?.uid;
    if (uid != null) {
      DocumentSnapshot userDoc =
          await firestore.collection('Users').doc(uid).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>;
      } else {
        throw Exception("No se encontraron datos para este usuario");
      }
    } else {
      throw Exception("Usuario no autenticado");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            var data = snapshot.data!;
            return SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: size.width * 0.03,
                      ),
                      Text('Bienvenido, ${data['name']} ${data['lastName']}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Expanded(child: Container()),
                      IconButton(
                          onPressed: () async {
                            await log.signOut();
                            Navigator.popAndPushNamed(context, '/');
                          },
                          icon: Icon(Icons.logout)),
                    ],
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Nivel de acceso registrado :'),
                        Text(
                          '${data['clearance']}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(height: size.height * 0.1),
                  if (data['isAdmin'] == true) ...[
                    Column(
                      children: [
                        StreamBuilder(
                            stream: fetchNonAdminUsers(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text("Error: ${snapshot.error}"));
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return Center(
                                    child: Text("No hay usuarios que mostrar"));
                              } else {
                                return Column(
                                  children: [
                                    Text('Usuarios Registrados'),
                                    Container(
                                      //color: Colors.purple,
                                      width: size.width * 0.7,
                                      height: size.height * 0.5,
                                      child: ListView.builder(
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            var userDoc =
                                                snapshot.data!.docs[index];
                                            var uid = userDoc.id;
                                            var data = userDoc.data()
                                                as Map<String, dynamic>;
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            UserDetailPage(
                                                              userData: data,
                                                              uid: uid,
                                                            )));
                                              },
                                              child: Card(
                                                child: ListTile(
                                                  title: Text(data['name'] ??
                                                      'Nombre no disponible'),
                                                  subtitle: Text(data['email']),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                );
                              }
                            }),
                      ],
                    )
                  ]
                ],
              ),
            );
          } else {
            return Center(child: Text("No se encontraron datos de usuario"));
          }
        },
      ),
    );
  }
}
