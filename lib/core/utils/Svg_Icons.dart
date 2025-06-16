import 'package:flutter/material.dart';
import "package:flutter_svg/flutter_svg.dart";
import 'package:handheld_beta/core/theme/ResponsiveConfig.dart';

class SvgIcons {
  static Widget icon(String iconName,
      {required BuildContext context,
      double heightFactor = 0.04, // Proporción de altura según la pantalla
      double widthFactor = 0.04, // Proporción de ancho según la pantalla
      Color color = Colors.black}) {
    final responsive = ResponsiveConfig(context);
    return SvgPicture.asset(
      'assets/icons/$iconName.svg',
      height: responsive.scaleHeight(heightFactor),
      width: responsive.scaleWidth(widthFactor),
      color: color,
    );
  }
}

// Estilo para íconos personalizados con ajuste responsivo
class IconStyle {
  final String iconName;
  final BuildContext context;
  final double sizeFactor; // Factor de tamaño dinámico

  IconStyle(this.iconName, this.context, {this.sizeFactor = 0.04});

  Widget get icon {
    final responsive = ResponsiveConfig(context);
    return SvgPicture.asset(
      'assets/icons/$iconName.svg',
      height: responsive.scaleWidth(sizeFactor),
      width: responsive.scaleWidth(sizeFactor),
      color: Colors.white,
    );
  }
}
