import 'package:flutter/material.dart';
import 'package:handheld_beta/core/theme/ResponsiveConfig.dart';
import '../utils/Svg_Icons.dart';

class FrontEnd {
  // Colores generales
  static Color primaryColor = Color(0xFF002d74);
  static Color secondaryColor = Color(0xFFffd100);
  static Color backgroundColor = Colors.white;

  // Estilo de texto para AppBar
  static TextStyle appBarTitleStyle(BuildContext context) {
    final responsive = ResponsiveConfig(context);
    return TextStyle(
      fontSize: responsive.scaleText(20),
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  // Estilos de letras
  static TextStyle pensilStyle(BuildContext context) {
    final responsive = ResponsiveConfig(context);
    return TextStyle(
      fontSize: responsive.scaleText(23),
      fontWeight: FontWeight.bold,
    );
  }

  //Estilos de Iconos Dinamicos
  static double iconSize(BuildContext context) {
    final responsive = ResponsiveConfig(context);
    return responsive.scaleText(20);
  }

  // Estilo de botones
  static ButtonStyle elevatedButtonStyle(BuildContext context) {
    final responsive = ResponsiveConfig(context);
    return ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF002d74),
      foregroundColor: Colors.white,
      minimumSize: Size(
          responsive.scaleWidth(0.04), // Ajusta el ancho del botón
          responsive.scaleHeight(0.04) // Ajusta la altura del botón
          ),
      padding: EdgeInsets.symmetric(
        horizontal: responsive.scaleWidth(0.5), // Relleno horizontal
        vertical: responsive.scaleHeight(0.5), // Relleno vertical
      ),
      textStyle: TextStyle(
        fontSize: responsive.scaleText(18),
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ).copyWith(
      iconColor: MaterialStateProperty.all(Colors.white),
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      ),
    );
  }

  // Estilo para íconos en los Card
  static EdgeInsets cardMargin =
      EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0);
  static EdgeInsets cardSymmetric =
      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0);
  static TextStyle subtitleStyle = TextStyle(
    fontSize: 14.0,
    color: Colors.black,
  );

  // Método para ruir un Card con los parámetros necesarios
  static Widget buildCard({
    required BuildContext context,
    required Widget leadingIcon,
    required List<String> details,
    required VoidCallback onTap,
    Color backgroundColor = Colors.white,
    EdgeInsets? margin,
    EdgeInsets? padding,
  }) {
    return Card(
      margin: margin ?? cardMargin,
      color: backgroundColor,
      child: ListTile(
        leading: leadingIcon,
        contentPadding: padding ?? cardSymmetric,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: details
              .map((detail) => Text(
                    detail,
                    style: subtitleStyle,
                  ))
              .toList(),
        ),
        onTap: onTap,
      ),
    );
  }

  // Margenes y separaciones
  static EdgeInsets defaultPadding = EdgeInsets.all(16.0);
  static EdgeInsets PaddingSymmetric = EdgeInsets.symmetric(vertical: 7);
  static double spaceBetweenButtons = 15.0;

  // Espaciadores comunes verticales
  static Widget smallSpacer = SizedBox(height: 5);
  static Widget mediumSpacer = SizedBox(height: 15);
  static Widget intermediumSpacer = SizedBox(height: 20);
  static Widget largeSpacer = SizedBox(height: 30);

  // Espaciadores comunes horizontales
  static Widget smallHorizontalSpacer = SizedBox(width: 5);
  static Widget mediumHorizontalSpacer = SizedBox(width: 15);
  static Widget intermediumHorizontalSpacer = SizedBox(width: 20);
  static Widget largeHorizontalSpacer = SizedBox(width: 30);

  // Estilo de un Column con espaciado
  static Widget spacedColumn({
    required BuildContext context,
    required List<Widget> children,
    double spacing = 10.0,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) {
    final responsive = ResponsiveConfig(context);
    List<Widget> spacedChildren = [];
    for (int i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i != children.length - 1) {
        spacedChildren
            .add(SizedBox(height: responsive.scaleHeight(spacing / 100)));
      }
    }
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: spacedChildren,
    );
  }
}
