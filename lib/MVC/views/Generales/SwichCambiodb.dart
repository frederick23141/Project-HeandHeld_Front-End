import 'package:flutter/material.dart';
import 'package:handheld_beta/core/constants/FrontEnd.dart';
import 'package:handheld_beta/core/constants/CustomMessages.dart';
import 'package:handheld_beta/core/theme/ResponsiveConfig.dart';
import 'package:handheld_beta/core/utils/Svg_Icons.dart';

import '../../Controller/DataBase/CambiodbController.dart';

class SwitchCambioDB extends StatefulWidget {
  @override
  _SwitchCambioDBState createState() => _SwitchCambioDBState();
}

class _SwitchCambioDBState extends State<SwitchCambioDB> {
  final CambiodbController controller = CambiodbController();
  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    searchController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveConfig(context);
    return ListTile(
      title: SizedBox(
        width: responsive.scaleWidth(0.5),
        child: Text(
          'Base Activa: ${CambiodbController.isTestDatabase ? "Prueba" : "Producción"}',
          style: FrontEnd.appBarTitleStyle(context),
        ),
      ),
      leading: SvgIcons.icon('database', context: context, color: Colors.white),
      trailing: Switch(
        activeColor: Colors.green,
        inactiveThumbColor: Colors.red,
        value: CambiodbController.isTestDatabase,
        onChanged: (bool value) => _showAuthorizationDialog(context, value),
      ),
    );
  }

  void _showAuthorizationDialog(BuildContext context, bool switchValue) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Autorización Requerida'),
          content: TextField(
            keyboardType: TextInputType.number,
            focusNode: focusNode,
            controller: searchController,
            decoration: const InputDecoration(
              labelText: 'Ingrese su cédula',
              icon: Icon(Icons.person),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: FrontEnd.elevatedButtonStyle(context),
              child: const Text('Verificar'),
              onPressed: () => _verifyAuthorization(context, switchValue),
            ),
          ],
        );
      },
    );
  }

  Future<void> _verifyAuthorization(
      BuildContext context, bool switchValue) async {
    int? nitCambiobd = int.tryParse(searchController.text);
    if (nitCambiobd == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mPermisos.errorValidarPermisos)),
      );
      return;
    }

    try {
      bool permisoCambio = await controller.verifyUsuarioCambiodb(nitCambiobd);
      if (permisoCambio) {
        setState(() {
          CambiodbController.setDatabaseState(switchValue);
        });

        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(mPermisos.permisosValidados)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(mPermisos.sinPermisosCorrectos)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mPermisos.errorValidarPermisos)),
      );
    }
  }
}
