import 'package:flutter/material.dart';
import 'package:handheld_beta/MVC/views/Ppal/Home.dart';
import 'package:handheld_beta/MVC/views/Ppal/login.dart';
import 'package:handheld_beta/core/config/Conexion.dart';
import 'package:handheld_beta/core/constants/FrontEnd.dart';
import 'package:handheld_beta/core/route/app_routes.dart';
import 'package:handheld_beta/core/route/on_generate_route.dart';
import 'MVC/Controller/DataBase/CambiodbController.dart';
import 'MVC/Views/Generales/SwichCambiodb.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Conexion.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App name',
      onGenerateRoute: RouteGenerator.onGenerate,
      initialRoute: AppRoutes.login,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: FrontEnd.primaryColor,
        scaffoldBackgroundColor: FrontEnd.backgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: FrontEnd.primaryColor,
          titleTextStyle: FrontEnd.appBarTitleStyle(context),
          centerTitle: true,
        ),
      ),
      /* home: Scaffold(
          appBar: AppBar(
            title: const Text('Corsan Internal Android Processes'),
          ),
          body: Login()),
          */
    );
  }
}
