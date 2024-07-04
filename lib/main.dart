import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:langspeak/config/providers/user_bloc/user_bloc.dart';
import 'package:langspeak/domain/usecase/user_usecase/user_usecase.dart';
import 'package:langspeak/infrastructure/driven_adapters/api/user_api/user_api.dart';
import 'package:langspeak/ui/pages/user/main.dart';
import 'package:langspeak/ui/pages/user/sign_up.dart';
import 'package:langspeak/ui/pages/user/sing_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final userApi = UserApi();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(
            UserUsecase(userApi),
          ),
        )
      ],
      child: MaterialApp(
        title: 'Langspeak',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(51, 56, 78, 1)),
          scaffoldBackgroundColor: const Color.fromRGBO(51, 56, 78, 1),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SignIn(),
          '/sign-up': (context) => const SignUp(),
          '/menu': (context) => const Main(),
        },
      ),
    );
  }
}
