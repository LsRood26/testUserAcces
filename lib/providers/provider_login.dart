import 'package:flutter/material.dart';

class ProviderLogin with ChangeNotifier {
  TextEditingController _correoController = TextEditingController(text: '');
  TextEditingController get correoController => _correoController;
  set correoController(TextEditingController value) {
    _correoController = value;
    notifyListeners();
  }

  TextEditingController _passwordController = TextEditingController(text: '');
  TextEditingController get passwordController => _passwordController;
  set passwordController(TextEditingController value) {
    _passwordController = value;
    notifyListeners();
  }

  TextEditingController _nameController = TextEditingController(text: '');
  TextEditingController get nameController => _nameController;
  set nameController(TextEditingController value) {
    _nameController = value;
    notifyListeners();
  }

  TextEditingController _lastNameController = TextEditingController(text: '');
  TextEditingController get lastNameController => _lastNameController;
  set lastNameController(TextEditingController value) {
    _lastNameController = value;
    notifyListeners();
  }

  cleanInputs() {
    _correoController.text = "";
    _passwordController.text = "";
  }

  cleanInputslogin() {
    _correoController.text = "";
    _passwordController.text = "";
    _nameController.text = '';
    _lastNameController.text = '';
  }
}
