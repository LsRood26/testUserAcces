import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:test_useracces/services/login.dart';
import 'package:test_useracces/providers/provider_login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<ProviderLogin>(context);
    final auth = LoginAuth();
    return Scaffold(
      body: Container(
        width: size.width * 1,
        height: size.height * 1,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width * 0.5,
              child: TextFormField(
                controller: provider.correoController,
                decoration: InputDecoration(hintText: 'Correo Electronico'),
              ),
            ),
            Container(
              width: size.width * 0.5,
              child: TextFormField(
                controller: provider.nameController,
                decoration: InputDecoration(hintText: 'name'),
              ),
            ),
            Container(
              width: size.width * 0.5,
              child: TextFormField(
                controller: provider.lastNameController,
                decoration: InputDecoration(hintText: 'last name'),
              ),
            ),
            Container(
              width: size.width * 0.5,
              child: TextFormField(
                controller: provider.passwordController,
                decoration: InputDecoration(hintText: 'password'),
              ),
            ),
            Container(
              color: Colors.black,
              child: TextButton(
                onPressed: () async {
                  final uid = await auth.signUp(
                      provider.correoController.text,
                      provider.passwordController.text,
                      provider.nameController.text,
                      provider.lastNameController.text);
                  /* if ( await auth.signUp(
                          provider.correoController.text,
                          provider.passwordController.text,
                          provider.nameController.text,
                          provider.lastNameController.text) ==
                      null) */
                  if (uid == null) {
                    print('error');
                  } else {
                    provider.cleanInputslogin();
                    Navigator.of(context).pushNamed('/homepage');
                  }

                  print('Registro exitoso');
                },
                child: Text(
                  'Iniciar Sesión',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
