// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: duplicate_ignore
// ignore: unused_import
// ignore_for_file: unused_import, use_build_context_synchronously

import 'dart:developer' as devtools show log;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';

import 'package:santehaggi/constants/routes.dart';
import 'package:santehaggi/services/auth/auth_service.dart';
import 'package:santehaggi/services/auth/bloc/auth_bloc.dart';
import 'package:santehaggi/services/auth/bloc/auth_event.dart';
import 'package:santehaggi/services/auth/bloc/auth_state.dart';
import 'package:santehaggi/services/auth/firebase_auth_provider.dart';
import 'package:santehaggi/views/login_view.dart';
import 'package:santehaggi/views/notes/create_update_note_view.dart';
import 'package:santehaggi/views/notes/notes_view.dart';
import 'package:santehaggi/views/register_view.dart';
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
        home: BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(FirebaseAuthProvider()),
          child: const HomePage(),
        ),
        routes: {
          createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
        });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else if (state is AuthStateNeedVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late final TextEditingController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CounterBloc(),
//       child: Scaffold(
//           appBar: AppBar(
//             title: const Text('Testing Bloc'),
//           ),
//           body: BlocConsumer<CounterBloc, CounterState>(
//               listener: (context, state) {
//             _controller.clear();
//           }, builder: (context, state) {
//             final invalidValue =
//                 (state is CounterStateInvalidNumber) ? state.invalidValue : '';
//             return Column(
//               children: [
//                 Text('Current value => ${state.value}'),
//                 Visibility(
//                   visible: state is CounterStateInvalidNumber,
//                   child: Text('Invalid value: $invalidValue'),
//                 ),
//                 TextField(
//                   controller: _controller,
//                   decoration: const InputDecoration(
//                     hintText: 'Enter a number',
//                   ),
//                   keyboardType: TextInputType.number,
//                 ),
//                 Row(
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         context
//                             .read<CounterBloc>()
//                             .add(DecrementEvent(_controller.text));
//                       },
//                       child: const Text('-'),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         context
//                             .read<CounterBloc>()
//                             .add(IncrementEvent(_controller.text));
//                       },
//                       child: const Text('+'),
//                     ),
//                   ],
//                 )
//               ],
//             );
//           })),
//     );
//   }
// }

// @immutable
// abstract class CounterState {
//   final int value;
//   const CounterState(
//     this.value,
//   );
// }

// class CounterStateValid extends CounterState {
//   const CounterStateValid(
//     int value,
//   ) : super(value);
// }

// class CounterStateInvalidNumber extends CounterState {
//   final String invalidValue;
//   const CounterStateInvalidNumber({
//     required this.invalidValue,
//     required int previousValue,
//   }) : super(previousValue);
// }

// @immutable
// abstract class CounterEvent {
//   final String value;
//   const CounterEvent(this.value);
// }

// class IncrementEvent extends CounterEvent {
//   const IncrementEvent(String value) : super(value);
// }

// class DecrementEvent extends CounterEvent {
//   const DecrementEvent(String value) : super(value);
// }

// class CounterBloc extends Bloc<CounterEvent, CounterState> {
//   CounterBloc() : super(const CounterStateValid(0)) {
//     on<IncrementEvent>((event, emit) {
//       final integer = int.tryParse(event.value);
//       if (integer == null) {
//         emit(CounterStateInvalidNumber(
//           invalidValue: event.value,
//           previousValue: state.value,
//         ));
//       } else {
//         emit(CounterStateValid(
//           state.value + integer,
//         ));
//       }
//     });
//     on<DecrementEvent>((event, emit) {
//       final integer = int.tryParse(event.value);
//       if (integer == null) {
//         emit(CounterStateInvalidNumber(
//           invalidValue: event.value,
//           previousValue: state.value,
//         ));
//       } else {
//         emit(CounterStateValid(
//           state.value - integer,
//         ));
//       }
//     });
//   }
// }

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
}
