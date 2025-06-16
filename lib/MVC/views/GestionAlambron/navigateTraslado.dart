import 'package:flutter/material.dart';

import 'package:handheld_beta/core/constants/FrontEnd.dart';
import 'package:handheld_beta/core/constants/CustomMessages.dart';
import '../../Model/ObtenerPedidoAlambron.dart';
import '../Generales/TrasladarView.dart';
import '../../Controller/Generales/PermisosTrasladoController.dart';

void navigateTraslado(BuildContext context, ObtenerPedidoAlambron pedido,
    String vistaOrigen, int bodega) {
  final controller = PermisostrasladoController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return _TrasladoDialog(
        controller: controller,
        pedido: pedido,
        vistaOrigen: vistaOrigen,
        bodega: bodega,
      );
    },
  );
}

class _TrasladoDialog extends StatefulWidget {
  final PermisostrasladoController controller;
  final ObtenerPedidoAlambron pedido;
  final String vistaOrigen;
  final int bodega;

  const _TrasladoDialog({
    required this.controller,
    required this.pedido,
    required this.vistaOrigen,
    required this.bodega,
  });

  @override
  State<_TrasladoDialog> createState() => _TrasladoDialogState();
}

class _TrasladoDialogState extends State<_TrasladoDialog> {
  final TextEditingController cedulaEntregaController = TextEditingController();
  final TextEditingController cedulaRecibeController = TextEditingController();

  @override
  void dispose() {
    cedulaEntregaController.dispose();
    cedulaRecibeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ingresar Cédulas'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: cedulaEntregaController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Coordinador',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          FrontEnd.mediumSpacer,
          TextFormField(
            controller: cedulaRecibeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Montacarguista',
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          style: FrontEnd.elevatedButtonStyle(context),
          child: Text('Verificar'),
          onPressed: () async {
            int? nitEntrega = int.tryParse(cedulaEntregaController.text);
            int? nitRecibe = int.tryParse(cedulaRecibeController.text);

            if (nitEntrega == null || nitRecibe == null) {
              _showSnackbar(mPermisos.ingresarCedulasValidas);
              return;
            }

            try {
              bool permisoTraslado = await widget.controller
                  .verifyPermisostraslado(nitEntrega, nitRecibe);

              if (permisoTraslado) {
                Navigator.of(context).pop();
                _showSnackbar(mPermisos.permisosValidados);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrasladarView(
                      pedido: widget.pedido,
                      vistaOrigen: widget.vistaOrigen,
                      bodega: widget.bodega,
                      nitEntrega: nitEntrega,
                      nitRecibe: nitRecibe,
                    ),
                  ),
                );
              } else {
                _showSnackbar(mPermisos.sinPermisosCorrectos);
              }
            } catch (e) {
              _showSnackbar(mPermisos.errorValidarPermisos);
            }
          },
        ),
      ],
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
