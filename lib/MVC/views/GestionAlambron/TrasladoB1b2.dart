import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:handheld_beta/MVC/Model/MovimientoBodega.dart';
import 'package:handheld_beta/MVC/Views/Ppal/Home.dart';
import 'package:handheld_beta/core/constants/CustomMessages.dart';

import 'dart:async';
import 'package:intl/intl.dart';
import 'package:handheld_beta/core/constants/FrontEnd.dart';
import '../../Controller/DataBase/CambiodbController.dart';
import '../../Controller/GestionAlambronController/PedidoController.dart';
import '../../Model/ObtenerPedidoAlambron.dart';
import 'navigateTraslado.dart';

class TrasladoB1b2View extends StatefulWidget {
  const TrasladoB1b2View({super.key});

  @override
  State<TrasladoB1b2View> createState() => _TrasladoB1b2ViewState();
}

class _TrasladoB1b2ViewState extends State<TrasladoB1b2View> {
  final PedidoController _controller = PedidoController();
  bool isTestDatabase = CambiodbController.isTestDatabase;

  late Future<List<ObtenerPedidoAlambron>> _pedidosFuture;
  String devolver = "N";

  @override
  void initState() {
    super.initState();
    _pedidosFuture = _controller.obtenerPedidos(devolver);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Traslado: Bod 1 - Bod-2',
          style: FrontEnd.appBarTitleStyle(context),
        ),
        centerTitle: true,
        backgroundColor: FrontEnd.primaryColor,
      ),
      body: Padding(
        padding: FrontEnd.defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FrontEnd.mediumSpacer,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: CustomButton(
                    icon: Icons.update,
                    label: 'Actualizar',
                    onPressed: () {
                      setState(() {
                        _pedidosFuture = _controller.obtenerPedidos(devolver);
                      });
                    },
                  ),
                ),
                FrontEnd.mediumHorizontalSpacer,
                Flexible(
                  child: CustomButton(
                    icon: Icons.exit_to_app,
                    label: 'Salir',
                    onPressed: () {
                      _controller.salir(context, Home());
                    },
                  ),
                ),
              ],
            ),
            FrontEnd.mediumSpacer,
            Expanded(
              child: FutureBuilder<List<ObtenerPedidoAlambron>>(
                future: _pedidosFuture,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(mGenericos.falloConexion),
                              FrontEnd.mediumSpacer,
                              CustomButton(
                                icon: Icons.refresh,
                                label: mGenericos.reintentar,
                                onPressed: () {
                                  setState(() {
                                    _pedidosFuture =
                                        _controller.obtenerPedidos(devolver);
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                          child: Text(mGenericos.sinDatos),
                        );
                      }
                      var pedidos = snapshot.data!;
                      return ListView.builder(
                        itemCount: pedidos.length,
                        itemBuilder: (context, index) {
                          final pedido = pedidos[index];
                          return FrontEnd.buildCard(
                            context: context,
                            leadingIcon: Icon(Icons.assignment),
                            details: [
                              'Pedido N° ${pedido.numero}',
                              'Fecha: ${DateFormat('dd/MM/yyyy').format(pedido.fecha!)}',
                              'Código: ${pedido.codigo ?? "Sin código"}',
                              'Pendiente: ${pedido.pendiente.toString()}',
                              'Descripción: ${pedido.descripcion ?? "Sin descripción"}',
                            ],
                            margin: FrontEnd.cardSymmetric,
                            padding: FrontEnd.cardMargin,
                            onTap: () {
                              navigateTraslado(
                                  context, pedido, 'Bod 1 a Bod 2', 1);
                            },
                          );
                        },
                      );
                    default:
                      return Center(child: Text(mGenericos.estadoDesconocido));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: FrontEnd.elevatedButtonStyle(context),
      icon: Icon(icon, size: FrontEnd.iconSize(context)),
      label: Text(label),
      onPressed: onPressed,
    );
  }
}
