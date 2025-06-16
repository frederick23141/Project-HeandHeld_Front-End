import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:handheld_beta/core/constants/FrontEnd.dart';
import 'package:handheld_beta/core/utils/Svg_Icons.dart';

import '../../Model/ObtenerPedidoGalvanizado.dart';
import '../../controller/DataBase/CambiodbController.dart';
import '../../controller/Generales/MovimientoBodegaController.dart';
import '../../controller/GestionAlambronController/ValidarTiketController.dart';
import '../../model/MovimientoBodega.dart';
import '../../model/ValidarTiket.dart';

class TrasladarGalv extends StatefulWidget {
  final ObtenerPedidoGalvanizado pedido;
  final String vistaOrigen;
  final int bodega;
  final int nitEntrega;
  final int nitRecibe;

  const TrasladarGalv({
    super.key,
    required this.pedido,
    required this.vistaOrigen,
    required this.bodega,
    required this.nitEntrega,
    required this.nitRecibe,
  });

  @override
  State<TrasladarGalv> createState() => _TrasladarGalvState();
}

class _TrasladarGalvState extends State<TrasladarGalv> {
  final ValidarTiketController _controller = ValidarTiketController();
  late Future<List<ValidarTiket>> _tiketFuture;
  final TextEditingController tiketController = TextEditingController();
  bool isTestDatabase = CambiodbController.isTestDatabase;
  late MovimientoBodegaController movimientoBodegaController;
  String deviceName = 'Movil';

  @override
  void initState() {
    super.initState();
    _tiketFuture = Future.value([]);
    movimientoBodegaController = MovimientoBodegaController();
    _getDeviceName();
  }

  Future<void> _getDeviceName() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    String name = 'Dispositivo desconocido';

    try {
      if (Theme.of(context).platform == TargetPlatform.android) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        name = androidInfo.model;
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        name = iosInfo.name;
      }
    } catch (e) {
      print('Error al obtener el nombre del dispositivo: $e');
    }

    setState(() {
      deviceName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movimiento: ${widget.vistaOrigen}'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Padding(
        padding: FrontEnd.defaultPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FrontEnd.smallSpacer,
            Text('Código: ${widget.pedido.codigo}',
                style: FrontEnd.pensilStyle(context)),
            FrontEnd.smallSpacer,
            formUI(),
            FutureBuilder<List<ValidarTiket>>(
              future: _tiketFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('Sin datos disponibles');
                }

                final tiket = snapshot.data!.first;
                if (widget.pedido.codigo != tiket.codigo) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      _tiketFuture = Future.error(
                          'Error: Código incorrecto (${widget.pedido.codigo} != ${tiket.codigo})');
                    });
                  });
                }

                return Column(
                  children: [
                    _buildCard(
                      leadingIcon:
                          SvgIcons.icon('alambobina', context: context),
                      details: [
                        'Peso: ${tiket.peso ?? 'N/A'}',
                        'Código: ${tiket.codigo ?? 'N/A'}',
                        'Descripción: ${tiket.descripcion ?? 'N/A'}',
                      ],
                    ),
                    _buildCard(
                      leadingIcon:
                          SvgIcons.icon('movimiento', context: context),
                      details: [
                        'Tipo: TRB1',
                        'Movimientos: ${tiket.movimiento ?? ''}',
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: FrontEnd.defaultPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildButton(
              icon: Icons.cleaning_services_outlined,
              label: 'Borrar',
              onPressed: () {
                setState(() {
                  tiketController.clear();
                  _tiketFuture = Future.value([]);
                });
              },
            ),
            FrontEnd.mediumHorizontalSpacer,
            _buildButton(
              icon: Icons.redo_outlined,
              label: 'Mover',
              onPressed: _moverTiket,
            ),
          ],
        ),
      ),
    );
  }

  void buscarTiket(String tiket) {
    setState(() {
      _tiketFuture = _controller.validarTiket(tiket);
    });
  }

  Widget _buildCard({
    required Widget leadingIcon,
    required List<String> details,
  }) {
    return FrontEnd.buildCard(
      context: context,
      leadingIcon: leadingIcon,
      details: details,
      onTap: () {},
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Flexible(
      child: ElevatedButton.icon(
        style: FrontEnd.elevatedButtonStyle(context),
        icon: Icon(icon, size: FrontEnd.iconSize(context)),
        label: Text(label),
        onPressed: onPressed,
      ),
    );
  }

  Future<void> _moverTiket() async {
    final String tiket = tiketController.text;
    try {
      await movimientoBodegaController.MovimientoBodegas(
          context,
          tiket,
          deviceName,
          widget.vistaOrigen as int,
          widget.bodega,
          widget.nitEntrega,
          widget.nitRecibe as String);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Movimiento realizado correctamente')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al realizar el movimiento: $e')),
      );
    }
  }

  formItemsDesing(Widget iconWidget, Widget item) {
    return Padding(
      padding: FrontEnd.PaddingSymmetric,
      child: Card(child: ListTile(leading: iconWidget, title: item)),
    );
  }

  Widget formUI() {
    return Column(children: <Widget>[
      formItemsDesing(
        SvgIcons.icon(
          'codigo-de-barras',
          context: context,
        ),
        TextFormField(
          controller: tiketController,
          decoration: const InputDecoration(labelText: 'Consecutivo'),
          maxLength: 20,
          onChanged: (value) => buscarTiket(value),
        ),
      )
    ]);
  }
}
