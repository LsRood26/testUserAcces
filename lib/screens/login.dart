import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_useracces/services/login.dart';
import 'package:test_useracces/providers/provider_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              titles('Instalacion ', 'Registro de usuarios'),
              Container(
                width: size.width * 0.5,
                child: TextFormField(
                  controller: provider.correoController,
                  decoration: InputDecoration(hintText: 'Correo Electronico'),
                ),
              ),
              Container(
                width: size.width * 0.5,
                child: TextField(
                  controller: provider.passwordController,
                  decoration: InputDecoration(hintText: 'Contraseña'),
                ),
              ),
              Container(
                width: size.width * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.purple,
                ),
                child: TextButton(
                  onPressed: () {
                    auth.signInEmailandPassword(provider.correoController.text,
                        provider.passwordController.text);
                    provider.cleanInputs();
                    Navigator.of(context).pushNamed('/homepage');
                    print('Login exitoso');
                  },
                  child: Text(
                    'Iniciar Sesión',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                width: size.width * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.purple,
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/register');
                  },
                  child: Text(
                    'Registrarse',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget titles(String urbName, String text) {
  return Column(
    children: [
      const Icon(Icons.location_city),
      Text(
        urbName,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          )),
    ],
  );
}
