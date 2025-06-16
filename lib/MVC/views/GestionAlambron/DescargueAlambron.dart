import 'package:flutter/material.dart';
import 'package:handheld_beta/core/constants/FrontEnd.dart';
import 'package:handheld_beta/core/theme/ResponsiveConfig.dart';
import 'package:handheld_beta/core/utils/Svg_Icons.dart';

import '../../Controller/DataBase/CambiodbController.dart';
import '../../Controller/GestionAlambronController/DescargueAlambronController.dart';
import '../../Controller/GestionAlambronController/PedidoController.dart';

import '../Ppal/Home.dart';

class DescargueAlambron extends StatefulWidget {
  const DescargueAlambron({super.key});

  @override
  _DescargueAlambronState createState() => _DescargueAlambronState();
}

class _DescargueAlambronState extends State<DescargueAlambron> {
  final DescargueAlambronController _controller = DescargueAlambronController();
  bool isTestDatabase = CambiodbController.isTestDatabase;
  TextEditingController placaCtrl = TextEditingController();
  TextEditingController pesoCargaCtrl = TextEditingController();
  TextEditingController pesoDescargadoCtrl = TextEditingController();
  TextEditingController cantidadRollosCamionCtrl = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey();

  @override
  void dispose() {
    _controller.dispose();
    placaCtrl.dispose();
    pesoCargaCtrl.dispose();
    pesoDescargadoCtrl.dispose();
    cantidadRollosCamionCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveConfig(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Descargue Alambrón',
          style: FrontEnd.appBarTitleStyle(context),
        ),
        backgroundColor: FrontEnd.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: FrontEnd.defaultPadding,
          child: Column(
            children: [
              Container(
                height: responsive
                    .scaleHeight(0.3), // 30% de la altura de la pantalla
                width:
                    responsive.scaleWidth(0.8), // 80% del ancho de la pantalla
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset(
                  'assets/animations/recibo.gif',
                  fit: BoxFit.contain,
                ),
              ),
              FrontEnd.smallSpacer,
              Form(
                key: keyForm,
                child: formUI(),
              ),
              FrontEnd.mediumSpacer,
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: FrontEnd.defaultPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
              child: ElevatedButton.icon(
                style: FrontEnd.elevatedButtonStyle(context),
                icon: const Icon(Icons.cleaning_services_outlined),
                label: const Text('Borrar'),
                onPressed: () {
                  setState(() {
                    placaCtrl.clear();
                    pesoCargaCtrl.clear();
                    pesoDescargadoCtrl.clear();
                    cantidadRollosCamionCtrl.clear();
                  });
                },
              ),
            ),
            FrontEnd.smallHorizontalSpacer,
            Flexible(
              child: ElevatedButton.icon(
                style: FrontEnd.elevatedButtonStyle(context),
                icon: const Icon(Icons.redo_outlined),
                label: const Text('Continuar'),
                onPressed: () async {
                  save();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  formItemsDesing(Widget iconWidget, Widget item) {
    return Padding(
      padding: FrontEnd.PaddingSymmetric,
      child: Card(child: ListTile(leading: iconWidget, title: item)),
    );
  }

  Widget formUI() {
    return Column(
      children: <Widget>[
        formItemsDesing(
            SvgIcons.icon(
              'placa',
              context: context,
            ),
            TextFormField(
                controller: placaCtrl,
                decoration: InputDecoration(
                  labelText: 'Placa',
                ),
                maxLength: 6,
                validator: (value) => validatePlaca(value!))),
        formItemsDesing(
            SvgIcons.icon(
              'tarea-pesada',
              context: context,
            ),
            TextFormField(
                controller: pesoCargaCtrl,
                decoration: InputDecoration(
                  labelText: 'Peso Carga',
                ),
                maxLength: 5,
                validator: (value) => validatePesoCarga(value!))),
        formItemsDesing(
            SvgIcons.icon(
              'escala-de-peso',
              context: context,
            ),
            TextFormField(
              controller: pesoDescargadoCtrl,
              decoration: InputDecoration(
                labelText: 'Peso Descargado',
              ),
              maxLength: 5,
              validator: (value) => validatePesoDescargue(value!),
            )),
        formItemsDesing(
            SvgIcons.icon(
              'rollos-fisicos',
              context: context,
            ),
            TextFormField(
                controller: cantidadRollosCamionCtrl,
                decoration:
                    InputDecoration(labelText: 'Cantidad Rollos Fisicos'),
                maxLength: 2,
                validator: (value) => validateRollosFisicos(value!)))
      ],
    );
  }

  String? validatePlaca(String? value) {
    String pattern = r'(^[a-zA-Z0-9 ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return "La Placa es necesaria";
    } else if (!regExp.hasMatch(value)) {
      return "La placa debe ser alfanumérica";
    }
    return null;
  }

  String? validatePesoCarga(String? value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return "El Peso de Carga es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "El Peso de Carga debe ser numérico";
    }
    return null;
  }

  String? validatePesoDescargue(String value) {
    if (value.isEmpty) {
      return "El Peso de Descargue es Necesario";
    } else if (value.length != 5) {
      return "";
    }
    return null;
  }

  String? validateRollosFisicos(String value) {
    if (value.isEmpty) {
      return "La cantidad de Rollos es Necesaria";
    } else if (value.length != 5) {
      return "";
    }
    return null;
  }

  void save() {
    if (keyForm.currentState != null && keyForm.currentState!.validate()) {
      print("Placa ${placaCtrl.text}");
      print("Peso Carga ${pesoCargaCtrl.text}");
      print("Peso Descargue ${pesoDescargadoCtrl.text}");
      print("Cantidad de Rollos Fisicos${cantidadRollosCamionCtrl.text}");
    }
  }
}
