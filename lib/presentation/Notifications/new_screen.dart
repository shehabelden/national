import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                    child: ListTile(
                      title: Text(context
                          .read<NotificationsCubit>()
                          .Notifications[index]['Acces']),
                      subtitle: Text(context
                          .read<NotificationsCubit>()
                          .Notifications[index]['Message']),
                    ),
                  );
                },
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
