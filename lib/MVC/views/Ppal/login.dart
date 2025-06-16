import 'package:flutter/material.dart';
import 'package:handheld_beta/MVC/Views/Generales/SwichCambiodb.dart';
import 'package:handheld_beta/MVC/views/Ppal/Home.dart';
import 'package:handheld_beta/core/constants/FrontEnd.dart';
import 'package:handheld_beta/core/theme/ResponsiveConfig.dart';
import '../../../core/utils/ScanController.dart';
import '../../Controller/DataBase/CambiodbController.dart';
import '../../Controller/Generales/UserController.dart';
import '../../model/Config_Gener/ScanModel/ScanModel.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late UserController controller;
  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  late ScanController scanController;
  final ScanModel scannerModel = ScanModel();
  bool isTestDatabase = CambiodbController.isTestDatabase;

  @override
  void initState() {
    super.initState();
    controller = UserController(isTestDatabase);
    scanController = ScanController(scannerModel);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveConfig(context);
    return Scaffold(
      body: Padding(
        padding: FrontEnd.defaultPadding,
        child: Center(
          child: Column(
            children: [
              Container(
                height: responsive.scaleHeight(0.5),
                width: responsive.scaleWidth(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Image.asset(
                  'assets/animations/logo.gif',
                  fit: BoxFit.contain,
                ),
              ),
              FrontEnd.intermediumSpacer,
              _buildLoginButton(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildSwich(context),
    );
  }

  Widget _buildSwich(BuildContext context) {
    return BottomAppBar(
      color: FrontEnd.primaryColor,
      child: Column(
        children: [
          FrontEnd.spacedColumn(context: context, children: [SwitchCambioDB()])
        ],
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton.icon(
      style: FrontEnd.elevatedButtonStyle(context),
      icon: Icon(
        Icons.co_present,
        size: FrontEnd.iconSize(context),
      ),
      label: const Text("Ingresar"),
      onPressed: () => _showScanDialog(context),
    );
  }

  void _showScanDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Escanea o escribe el Documento'),
          content: _buildScanDialogContent(),
          actions: _buildScanDialogActions(context),
        );
      },
    );
  }

  Widget _buildScanDialogContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          keyboardType: TextInputType.number,
          focusNode: focusNode,
          controller: searchController,
          decoration: const InputDecoration(
            icon: Icon(Icons.qr_code_scanner),
          ),
          onTap: () async {
            await scanController.scanAndUpdate(searchController);
            searchController.clear();
            focusNode.requestFocus();
          },
        ),
      ],
    );
  }

  List<Widget> _buildScanDialogActions(BuildContext context) {
    return [
      TextButton(
        child: const Text('Cancelar'),
        onPressed: () => Navigator.of(context).pop(),
      ),
      ElevatedButton(
        style: FrontEnd.elevatedButtonStyle(context),
        child: const Text('Verificar'),
        onPressed: () => _verifyUser(context),
      ),
    ];
  }

  Future<void> _verifyUser(BuildContext context) async {
    int? inputNit = int.tryParse(searchController.text);
    if (inputNit == null) {
      _showSnackbar(context, 'Por favor ingrese una cédula válida');
      return;
    }

    try {
      var usuario = await controller.verifyUsuario(inputNit);
      if (usuario != null) {
        _handleSuccessfulLogin(context, usuario);
      } else {
        _showSnackbar(context, 'Cédula no encontrada o inválida');
      }
    } catch (e) {
      _showSnackbar(context, 'Error: $e');
    }
  }

  void _handleSuccessfulLogin(BuildContext context, var usuario) {
    String? usuarioName = usuario.nombres;
    Navigator.of(context).pop();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
    _showSnackbar(context, 'Bienvenido, $usuarioName');
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
