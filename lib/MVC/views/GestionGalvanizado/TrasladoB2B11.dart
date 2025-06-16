import 'package:flutter/material.dart';
import 'package:handheld_beta/core/constants/CustomMessages.dart';
import 'package:intl/intl.dart';

import 'package:handheld_beta/core/constants/FrontEnd.dart';
import '../../Controller/GestionGalvanizadoController/GalvanizadoController.dart';
import '../../Model/ObtenerPedidoGalvanizado.dart';
import '../../controller/DataBase/CambiodbController.dart';
import '../Ppal/Home.dart';
import 'navigateTrasladoGalv.dart';

class Trasladob2b11View extends StatefulWidget {
  const Trasladob2b11View({super.key});

  @override
  State<Trasladob2b11View> createState() => _Trasladob2b11ViewState();
}

class _Trasladob2b11ViewState extends State<Trasladob2b11View> {
  final GalvanizadoController _controller = GalvanizadoController();
  bool isTestDatabase = CambiodbController.isTestDatabase;

  late Future<List<ObtenerPedidoGalvanizado>> _galvanizadoFuture;
  String devolver = "";

  @override
  void initState() {
    super.initState();
    _galvanizadoFuture = _controller.ObtenerPedidoGalvanizados(devolver);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Traslado: Bod 11 - Bod 2',
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
                        _galvanizadoFuture =
                            _controller.ObtenerPedidoGalvanizados(devolver);
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
              child: FutureBuilder<List<ObtenerPedidoGalvanizado>>(
                future: _galvanizadoFuture,
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
                                    _galvanizadoFuture =
                                        _controller.ObtenerPedidoGalvanizados(
                                            devolver);
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
                      var Gpedidos = snapshot.data!;
                      return ListView.builder(
                        itemCount: Gpedidos.length,
                        itemBuilder: (context, index) {
                          final pedido = Gpedidos[index];
                          return FrontEnd.buildCard(
                            context: context,
                            leadingIcon: Icon(Icons.assignment),
                            details: [
                              'Gpedido N° ${pedido.numero}',
                              'Fecha: ${DateFormat('dd/MM/yyyy').format(pedido.fecha!)}',
                              'Código: ${pedido.codigo ?? "Sin código"}',
                              'Pendiente: ${pedido.pendiente.toString()}',
                              'Descripción: ${pedido.descripcion ?? "Sin descripción"}',
                            ],
                            margin: FrontEnd.cardSymmetric,
                            padding: FrontEnd.cardMargin,
                            onTap: () {
                              navigateTrasladoGalv(
                                  context, pedido, 'Bod 11 a Bod 2', 2);
                            },
                          );
                        },
                      );
                    default:
                      return Center(child: Text(mGenericos.sinDatos));
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
