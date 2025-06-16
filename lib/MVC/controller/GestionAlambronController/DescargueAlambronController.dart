import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';

class DescargueAlambronController {
  TextEditingController placaController = TextEditingController();
  TextEditingController pesoCargaController = TextEditingController();
  TextEditingController pesoDescargadoController = TextEditingController();
  TextEditingController cantidadRollosCamionController =
      TextEditingController();

  void dispose() {
    placaController.dispose();
    pesoCargaController.dispose();
    pesoDescargadoController.dispose();
    cantidadRollosCamionController.dispose();
  }
}