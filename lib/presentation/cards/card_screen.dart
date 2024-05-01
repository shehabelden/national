import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:national/presentation/cards/cubit/state.dart';
import 'package:national/presentation/my_card/my_card.dart';
import '../all_cards/all_cards_screen.dart';
import 'cubit/cubit.dart';
import 'widget/card_image.dart';
import 'widget/history_list.dart';
class CardScreen extends StatelessWidget{
  const CardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    CardsCubit cubit=CardsCubit.get(context);
    cubit.getMyDataCubit();
    cubit.getHistory();
    return BlocBuilder<CardsCubit,CardMainState>(
        builder: (context,state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Column(
              children: [
                 Padding(
                  padding:const  EdgeInsets.only(right: 80.0),
                  child:  Text("Welcome, ${cubit.profileMap["name"]}",
                    style:const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),),
                ),
                const SizedBox(height: 40,),
                Row(
                  children: [
                    const SizedBox(width: 50,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_){
                          return const AllCardsScreen();
                        }));
                      },
                      child: Container(
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                          color:const Color(0xFF800f2f),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child:const Text("See All Cards",style: TextStyle(
                            color: Colors.white
                        )),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    InkWell(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (_){
                          return const MyCard();
                        }));

                      },
                      child: Container(
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color:const Color(0xFF800f2f),
                          ),
                        ),
                        alignment: Alignment.center,
                        child:const Text("See Card",style: TextStyle(
                          color: Color(0xFF800f2f),
                        ),),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40,),
                const CardImage(),
                const Padding(
                  padding:  EdgeInsets.only(right: 200.0,top: 20),
                  child: Text("history",style: TextStyle(
                    color: Color(0xFF800f2f),
                    fontSize: 24,
                  ),),
                ),
                 HistoryList(history:cubit.history),
              ],
            ),
          ),
        );
      }
    );
  }
}