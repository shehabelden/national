import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../NotficationHelper/notificationHelper.dart';
import 'Cubit/notifications_cubit.dart';
import 'Cubit/notifications_state.dart';

class NewScreen extends StatelessWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NotificationsCubit>(context).notificationRead();

    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NotificationsSucced) {
            return Container(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 120,
                      color: Colors.white,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              context
                                  .read<NotificationsCubit>()
                                  .Notifications[index]['Acces'],
                              style: TextStyle(color: Color(0xFF800f2f)),
                            ),
                            subtitle: Text(
                              context
                                  .read<NotificationsCubit>()
                                  .Notifications[index]['Message'],
                              style: TextStyle(color: Color(0xFF800f2f)),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Spacer(),
                              InkWell(
                                onTap: () async {
                                  BlocProvider.of<NotificationsCubit>(context)
                                      .StartNotification(
                                          FirebaseAuth.instance.currentUser!
                                              .displayName,
                                          FirebaseAuth
                                              .instance.currentUser!.uid);
                                  await firebaseApi().initNotifications();
                                },
                                child: Text(
                                  "Accept",
                                  style: TextStyle(color: Color(0xFF800f2f)),
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  "Reject",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                              Spacer(),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                //
                itemCount:
                    context.read<NotificationsCubit>().Notifications.length,
              ),
            );
          } else if (state is NotificationsError) {
            return Center(
              child: Text('Something went wrong!'),
            );
          } else {
            return Center(
              child: Text('Unhandled state!'),
            );
          }
        },
      ),
    );
  }
}
