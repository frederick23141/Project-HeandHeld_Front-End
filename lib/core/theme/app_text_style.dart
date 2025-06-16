import 'package:flutter/material.dart';
import '../utils/app_responsive.dart';

class AppTextStyle {
  static TextStyle appBarTitleStyle(BuildContext context) {
    final responsive = AppResponsive(context);

    return TextStyle(
      fontSize: responsive.scaleText(20),
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  static TextStyle pensilStyle(BuildContext context) {
    final responsive = AppResponsive(context);

    return TextStyle(
      fontSize: responsive.scaleText(23),
      fontWeight: FontWeight.bold,
    );
  }
}
