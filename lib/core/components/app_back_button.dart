import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset('namesvg'),
      onPressed: () => Navigator.pop(context),
    );
  }
}
