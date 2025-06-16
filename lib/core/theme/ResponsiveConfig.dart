import 'package:flutter/material.dart';

class ResponsiveConfig {
  final BuildContext context;
  late double _screenWidth;
  late double _screenHeight;
  late double _devicePixelRatio;
  late Orientation _orientation;
  late bool _isMobile;
  late bool _isTablet;
  late bool _isDesktop;

  // Constructor: inicializamos las propiedades una vez
  ResponsiveConfig(this.context) {
    final mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _devicePixelRatio = mediaQuery.devicePixelRatio;
    _orientation = mediaQuery.orientation;
    _isMobile = _screenWidth < 600;
    _isTablet = _screenWidth >= 600 && _screenWidth < 1024;
    _isDesktop = _screenWidth >= 1024;
  }

  // Getters para las propiedades
  double get screenWidth => _screenWidth;
  double get screenHeight => _screenHeight;
  double get devicePixelRatio => _devicePixelRatio;
  Orientation get orientation => _orientation;
  bool get isMobile => _isMobile;
  bool get isTablet => _isTablet;
  bool get isDesktop => _isDesktop;

  // Métodos de escalado de ancho y alto
  double scaleWidth(double factor) => screenWidth * factor;
  double scaleHeight(double factor) => screenHeight * factor;

  // Escalado de texto
  double scaleText(double baseSize) {
    if (isMobile) return baseSize;
    if (isTablet) return baseSize * 1.2;
    return baseSize * 1.4;
  }

  // Márgenes o padding dinámicos
  EdgeInsets dynamicPadding({double mobile = 16, double tablet = 24, double desktop = 32}) {
    if (isMobile) return EdgeInsets.all(mobile);
    if (isTablet) return EdgeInsets.all(tablet);
    return EdgeInsets.all(desktop);
  }

  // Tamaño dinámico de botones
  Size dynamicButtonSize({Size mobile = const Size(120, 50), Size tablet = const Size(150, 60), Size desktop = const Size(180, 70)}) {
    if (isMobile) return mobile;
    if (isTablet) return tablet;
    return desktop;
  }

  // Método para construir un diseño responsivo en columnas
  Widget responsiveColumn({
    required List<Widget> children,
    double spacing = 10.0,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) {
    List<Widget> spacedChildren = [];
    for (int i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i != children.length - 1) {
        spacedChildren.add(SizedBox(height: spacing));
      }
    }
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: spacedChildren,
    );
  }
}

