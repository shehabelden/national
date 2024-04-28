import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:national/new_screen.dart';
import 'package:national/notificationHelper.dart';
import 'package:national/presentation/auth/cubit/cubit.dart';
import 'package:national/presentation/auth/login_check.dart';
import 'package:national/presentation/family/cubit/cubit.dart';
import 'package:national/presentation/family/family_screen.dart';
import 'package:national/presentation/main_screen/cubit/cubit.dart';
import 'firebase_options.dart';
import 'presentation/all_cards/cubit/cubit.dart';
import 'presentation/cards/cubit/cubit.dart';

final navigate = GlobalKey<NavigatorState>();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
await firebaseApi().initNotifications();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => MainCubit()),
        BlocProvider(create: (context) => FamilyCubit()),
        BlocProvider(create: (context) => CardsCubit()),
        BlocProvider(create: (context) => AllCardsCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: "/home",
        routes: {
          "/home": (context) => LoginCheck(),
          '/hh': (context) => NewScreen(),
        },
        home: const LoginCheck(),
      ),
    );
  }
}
/