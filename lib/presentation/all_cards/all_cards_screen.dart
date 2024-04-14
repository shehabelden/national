import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/var/controllers.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
class AllCardsScreen extends StatelessWidget {
  const AllCardsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    AllCardsCubit cubit =AllCardsCubit.get(context);
    cubit.getAllCardsCubit();
    return  Scaffold(
      appBar: AppBar(),
      body:BlocBuilder<AllCardsCubit,AllCardsMainState>(
          builder: (context,state) {
          return state is GetEmptyState || cubit.getAllCardsList.isEmpty ? const Center(child: CircularProgressIndicator(),) :
          ListView.builder(
            itemCount:cubit.getAllCardsList.length,
            itemBuilder: (context,index) {
              return  Padding(
                padding: const EdgeInsets.only(left: 20.0,bottom: 20,top: 20),
                child: InkWell(
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title:const Text("edit card"),
                          actions: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  decoration:const InputDecoration(
                                      label: Text("add note")),
                                  controller: Controllers.userNameController,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0,bottom: 20.0),
                                  child: InkWell(
                                    onTap: ()async{
                                      await cubit.addAllCardsImage(cubit.getAllCardsListId[index]);
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.white
                                      ),
                                      child:const Text("+"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 60.0),
                                  child: InkWell(
                                    onTap: () async{
                                      print(cubit.getAllCardsListId[index]);
                                      await cubit.addUpdate(cubit.getAllCardsListId[index],{
                                        "massege":Controllers.userNameController.text,
                                        // "image":cubit.getimage!,
                                        "request_name":"update card",
                                        "status":"pending",
                                      });
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Color(0xFF800f2f),
                                          borderRadius: BorderRadius.circular(12)
                                      ),
                                      alignment: Alignment.center,
                                      child:const Text("add card",style: TextStyle(
                                          color: Colors.white
                                      ),),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ));
                    // cubit.addAllCardsImage("national_card");
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                       const Icon(Icons.credit_card_rounded),
                        Text(cubit.getAllCardsList[index]["name"]),
                      ],
                    ),
                  ),
                ),
              );
            }
          );
        }
      ) ,
    );
  }
}
