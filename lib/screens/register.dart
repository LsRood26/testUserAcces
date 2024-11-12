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
      body: SafeArea(
        child: Container(
          width: size.width * 1,
          height: size.height * 1,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Registrarse',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: size.height * 0.03),
              ),
              entryField('Correo Electronico', provider.correoController, size),
              entryField('Nombre', provider.nameController, size),
              entryField('Apellido', provider.lastNameController, size),
              entryField('Contraseña', provider.passwordController, size),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.purple,
                ),
                child: TextButton(
                  onPressed: () async {
                    final uid = await auth.signUp(
                        provider.correoController.text,
                        provider.passwordController.text,
                        provider.nameController.text,
                        provider.lastNameController.text);
                    if (uid == null) {
                    } else {
                      provider.cleanInputslogin();
                      Navigator.of(context).pushNamed('/homepage');
                    }
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
      ),
    );
  }
}

Widget entryField(
    String etiqueta, TextEditingController controller, Size size) {
  return Container(
    width: size.width * 0.5,
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: etiqueta),
    ),
  );
}
