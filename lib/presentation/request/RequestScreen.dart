import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cards/cubit/cubit.dart';
import '../cards/cubit/state.dart';
class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key});
  @override
  Widget build(BuildContext context) {
    CardsCubit cubit=CardsCubit.get(context);
    cubit.requestListCubit();
    return Scaffold(
      body:  BlocBuilder<CardsCubit,CardMainState>(
          builder: (context,state) {
          return state is EmptyState || cubit.requetList.isEmpty ? Center(child: CircularProgressIndicator(),) :  Padding(
            padding: const EdgeInsets.only(top: 40,left: 50),
            child: SizedBox(
              width: 250,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: cubit.requetList.length,
                  itemBuilder: (c,index){
                    return Padding(
                      padding: const EdgeInsets.only(left: 20.0,top: 20),
                      child: InkWell(
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title:const Text("why my request rejected",style: TextStyle(
                                  color: Color(0xFF800f2f),
                                  fontWeight: FontWeight.bold,
                                ),),
                                actions: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(cubit.requetList[index]["massege"]),
                                    ],
                                  )
                                ],
                              )
                          );
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                            ],

                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0,left: 20),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    width: 300,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(flex: 1,
                                          child: Text("request name :",style: TextStyle(
                                            color: Color(0xFF800f2f),
                                            fontWeight: FontWeight.bold,
                                          ),),
                                        ),

                                        Expanded(flex: 1,child: Text(" ${cubit.requetList[index]["request_name"]}",maxLines: 3)),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Text("status :",style: TextStyle(
                                        color: Color(0xFF800f2f),
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      Text(" ${cubit.requetList[index]["status"]}"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          );
        }
      ),
    );
  }
}
