import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';
import 'package:national/presentation/Notifications/Cubit/notifications_state.dart';
import 'package:http/http.dart' as http;

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  // Specify the type for the Notifications list
  List Notifications = [];

  // Make sure to add a return type for the method
  notificationRead() async {
    emit(NotificationsLoading());

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("Profile")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("notification")
          .get();

      Notifications.clear();

      querySnapshot.docs.forEach((document) {
        Notifications.add(document.data());
        print(document.data());
      });

      emit(NotificationsSucced());
    } catch (error) {
      emit(NotificationsError(
        Error: error.toString(),
      ));
    }
  }

  void StartNotification(var name, String token) async {
    FirebaseMessaging.instance.getToken().then((value) {
      print(value);
    });
    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'key=epOawSxdRP6ZcTzEhhs70_:APA91bE9qHYfpJnPzFu23sYOO-JVKemHAvitNJ626NSgAugiCia0dlphv-xB9tZlTRUr9Djh9RPk3F_-xvfGMaAaU1kyweRJwXBsgNdni8kSXh9ILUOHhSZiKSGaxUD9f6NJUoY145FO',
    };
    final bodyData = {
      'notification': {
        'title': "hi $name we need acces to see }",
        "data": {
          "admin_token": "ss",
        },
        'body': "H",
      },
      'to': token,
    };
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(bodyData),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification. Error: ${response.body}');
    }
  }
}
