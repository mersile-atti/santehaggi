import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:santehaggi/services/auth/auth_exceptions.dart';
import 'package:santehaggi/services/auth/bloc/auth_bloc.dart';
import 'package:santehaggi/services/auth/bloc/auth_state.dart';
import 'package:santehaggi/utilities/show_error_dialog.dart';

import '../services/auth/bloc/auth_event.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateRegistering) {
          if (state.exception is WeakPasswordAuthException) {
            showErrorDialog(context, "Weak Password!");
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            showErrorDialog(context, 'Email is already in use');
          } else if (state.exception is InvalidEmailAuthException) {
            showErrorDialog(context, "Invalid email");
          } else if (state.exception is GenericAuthException) {
            showErrorDialog(
              context,
              'Failed to register',
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: Column(
          children: [
            TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Enter your email",
              ),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
              decoration: const InputDecoration(
                hintText: "Enter your password",
              ),
            ),
            TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                // ignore: unused_local_variable
                context.read<AuthBloc>().add(AuthEventRegister(
                      email,
                      password,
                    ));
              },
              child: const Text('Register'),
            ),
            TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        const AuthEventLogOut(),
                      );
                },
                child: const Text('Already registered? Login here!'))
          ],
        ),
      ),
    );
  }
}
