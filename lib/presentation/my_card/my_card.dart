import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../all_cards/cubit/cubit.dart';
import '../all_cards/cubit/state.dart';
class MyCard extends StatelessWidget {
  const MyCard({super.key});

  @override
  Widget build(BuildContext context) {
    AllCardsCubit cubit =AllCardsCubit.get(context);
    cubit.getAllCardsCubit();
    return  Scaffold(
        appBar: AppBar(),
    body:BlocBuilder<AllCardsCubit,AllCardsMainState>(
    builder: (context,state) {
          return Center(
            child: InkWell(
              onTap: (){
                cubit.redar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('card is read'),
                    action: SnackBarAction(
                      label: '',
                      onPressed: () {
                        // Code to execute.
                      },
                    ),
                  ),
                );
              },
              child: Container(
                width: 120,
                height: 50,
                alignment: Alignment.center,
                color: Color(0xFF800f2f),
                child:const Text("Add New card"),
              ),
            ),
          );
        }
      ),
    );
  }
}
