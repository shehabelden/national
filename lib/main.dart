import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:national/new_screen.dart';
import 'package:national/presentation/auth/cubit/cubit.dart';
import 'package:national/presentation/auth/login_check.dart';
import 'package:national/presentation/family/cubit/cubit.dart';
import 'package:national/presentation/family/family_screen.dart';
import 'package:national/presentation/main_screen/cubit/cubit.dart';
import 'firebase_options.dart';
import 'presentation/all_cards/cubit/cubit.dart';
import 'presentation/cards/cubit/cubit.dart';
final navigate=GlobalKey<NavigatorState>();
class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    FirebaseMessaging.instance.getInitialMessage();
    Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
      await Firebase.initializeApp();
      print("Handling a background message: ${message.messageId}");
    }
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle background messages
      void _handleNotificationClick(RemoteMessage message) {
        // Extract data from the message
      }});
    void handleNotification(RemoteMessage message) {
      // Extract the necessary data from the notification message
      final notificationData = message.data;
      final notificationType = notificationData['type'];
      navigate.currentState!.pushNamed("/home",);

    }
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      // Listneing to the foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
      }
      });
      await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
      );
  }

  void handleNotification(RemoteMessage message) {
    // Handle the notification message
    // You can show an alert dialog, navigate to a specific screen, etc.
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.instance.getInitialMessage();
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print("Handling a background message: ${message.messageId}");
  }
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    final notificationData = message.data;
    final notificationType = notificationData['type'];
    navigate.currentState!.pushNamed("/hh",);

  });

  // Listneing to the foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
    sound: true,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

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