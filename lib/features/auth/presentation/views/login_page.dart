import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handheld_beta/core/route/app_routes.dart';
import 'package:handheld_beta/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:handheld_beta/features/auth/presentation/bloc/auth_event.dart';
import 'package:handheld_beta/features/auth/presentation/bloc/auth_state.dart';
import 'package:handheld_beta/features/auth/auth_injection.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final TextEditingController _nitController = TextEditingController();

  void _onLoginPressed() {
    final nitText = _nitController.text.trim();
    if (nitText.isEmpty) return;

    final nit = int.tryParse(nitText);
    if (nit == null) {
      // Mostrar error
      return;
    }

    context.read<AuthBloc>().add(VerifyUserEvent(nit));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Bienvenido: ${state.user.nit}')),
              );
              // Aquí podrías navegar a Home si deseas:
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                TextField(
                  controller: _nitController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'NIT',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                state is AuthLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _onLoginPressed,
                        child: const Text('Iniciar Sesión'),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
