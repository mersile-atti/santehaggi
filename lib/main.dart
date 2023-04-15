// ignore: duplicate_ignore
// ignore: unused_import
// ignore_for_file: unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:santehaggi/views/login_view.dart';
import 'package:santehaggi/views/register_view.dart';
import 'package:rive/rive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:santehaggi/views/verify_email_view.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
        routes: {
          '/login/': (context) => const LoginView(),
          '/register/': (context) => const RegisterView()
        });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                print('Email verified');
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
            return const Text('Done');
          default:
            return const Text("Loading...");
        }
      },
    );
  }
}



/* void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

final splashProvider = FutureProvider<void>((_) async {
  await Future.delayed(const Duration(seconds: 3));
});

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  get splashProvider => FutureProvider<void>((_) async {
        await Future.delayed(const Duration(seconds: 3));
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Consumer(
        builder: (context, watch, child) {
          final FutureProvider<void> futureProvider = watch(splashProvider);

          return FutureProvider.when(
            data: (_) => const MyHomePage(),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, stackTrace) => const Center(child: Text('Error')),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: const Center(
        child: Text('Welcome to Flutter!'),
      ),
    );
  }
} */
