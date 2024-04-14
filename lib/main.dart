import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:national/presentation/auth/cubit/cubit.dart';
import 'package:national/presentation/auth/login_check.dart';
import 'package:national/presentation/family/cubit/cubit.dart';
import 'package:national/presentation/main_screen/cubit/cubit.dart';
import 'firebase_options.dart';
import 'presentation/all_cards/cubit/cubit.dart';
import 'presentation/cards/cubit/cubit.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AuthCubit()),
        BlocProvider(create: (context)=>MainCubit()),
        BlocProvider(create: (context)=>FamilyCubit()),
        BlocProvider(create: (context)=>CardsCubit()),
        BlocProvider(create: (context)=>AllCardsCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginCheck(),
      ),
    );
  }
}