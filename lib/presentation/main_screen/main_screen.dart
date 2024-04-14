import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:national/presentation/main_screen/cubit/state.dart';

import 'cubit/cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MainCubit cubit =MainCubit.get(context);
    return  BlocBuilder<MainCubit,MainState>(
      builder: (context,state) {
        return Scaffold(
          body:cubit.screens[cubit.index],
          bottomNavigationBar: BottomNavigationBar(
            items: const[
              BottomNavigationBarItem(icon: Icon(Icons.credit_card),label: "card"),
              BottomNavigationBarItem(icon: Icon(Icons.family_restroom),label:"family"),
              BottomNavigationBarItem(icon: Icon(Icons.request_page),label:"request"),
            ],
            currentIndex :cubit.index,
            selectedItemColor:const Color(0xFF800f2f),
            onTap: (i){
              cubit.screenCubit(i);
            },
          ),
        );
      }
    );
  }
}
