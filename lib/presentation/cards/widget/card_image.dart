import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
List stateList=["Insurance","driving_license","national_card"];
class CardImage extends StatelessWidget {
  const CardImage({super.key});
  @override
  Widget build(BuildContext context) {
    CardsCubit cubit=CardsCubit.get(context);
    cubit.getCard(stateList[cubit.index]);
    cubit.getAllCards();
    return  BlocBuilder<CardsCubit,CardMainState>(
      builder: (context,state) {
        return state is EmptyAll || cubit.cardsList.isEmpty ? const Center(child: CircularProgressIndicator(),) : Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20.0),
          child: SizedBox(
            width: 300,
            height: 400,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: cubit.cardsList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index) {
                cubit.getNum(index);
                return SizedBox(
                  width: 300,
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cubit.cardsList[index]["name"],style:const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF800f2f),
                      ),),
                      const SizedBox(height: 20,),
                      cubit.cardsList[index]["image"] ==null|| cubit.cardsList[index]["status"] == null || cubit.cardsList[index]["status"] =="pending"? InkWell(
                        onTap: (){
                          cubit.addCardImage(stateList[index]);
                        },
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(cubit.cardsList[index]["image"] ==null? "add new ${cubit.cardsList[index]["name"]}":"in ${cubit.cardsList[index]["status"]}  ${cubit.cardsList[index]["name"]}"),
                        ),
                      ) :  Container(
                        height: 200,
                        width: double.infinity,
                        decoration:cubit.cardsList[index]["image"] ==null ? const BoxDecoration(): BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage(cubit.cardsList[index]["image"]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            ),
          ),
        );
      }
    );
  }
}
