import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:national/presentation/Notifications/Cubit/notifications_state.dart';


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
      emit(NotificationsError( Error: error.toString(),));
    }
  }
}
