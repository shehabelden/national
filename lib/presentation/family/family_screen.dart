import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:national/presentation/family/cubit/cubit.dart';
import 'package:national/presentation/family/cubit/state.dart';
import '../../utils/var/controllers.dart';
import 'widget/add_family_member.dart';
class FamilyScreen extends StatelessWidget {
  const FamilyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    FamilyCubit cubit=FamilyCubit.get(context);
    cubit.getFamilyMemberCubit();
    return  BlocBuilder<FamilyCubit,FamilyMainState>(
        builder: (context,state) {
        return cubit.getFamilyMemberList.isEmpty || state is GetEmptyState ? const Center(
          child: CircularProgressIndicator(),) : Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40,left: 50),
              child: SizedBox(
                width: 250,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: cubit.getFamilyMemberList.length,
                    itemBuilder: (c,index){
                  return Padding(
                    padding: const EdgeInsets.only(left: 20.0,top: 20),
                    child: InkWell(
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title:const Text("update family member",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF800f2f)
                              ),),
                              actions: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextField(
                                      decoration:const InputDecoration(
                                          label: Text("name")),
                                      controller: Controllers.userNameController,
                                    ),
                                    TextField(
                                      decoration:const InputDecoration(
                                          label: Text("national")),
                                      controller: Controllers.nationalIdController,
                                    ),
                                    TextField(
                                      decoration:const InputDecoration(
                                          label: Text("add note")),
                                      controller: Controllers.massegeController,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0,bottom: 20.0),
                                      child: InkWell(
                                        onTap: ()async{
                                          await cubit.addFamilyImage();
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
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: InkWell(
                                        onTap: () async{
                                          cubit.updateFamilyMemberCubit({
                                            "name":Controllers.userNameController.text,
                                            "national_id":Controllers.nationalIdController.text,
                                            "image": cubit.getimage!,
                                            "massege":Controllers.massegeController.text,
                                            "request_name":"update family member",
                                            "status":"in progress",
                                          },cubit.getFamilyMemberListId[index]);
                                        },
                                        child: Container(
                                          width: 200,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color:const Color(0xFF800f2f),
                                              borderRadius: BorderRadius.circular(12),
                                          ),
                                          alignment: Alignment.center,
                                          child:const Text("update family member",style: TextStyle(
                                              color: Colors.white
                                          ),),
                                        ),
                                      ),
                                    ),

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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("name :",style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF800f2f)
                                  ),),
                                  Text("${cubit.getFamilyMemberList[index]["name"]}"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("national id :",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF800f2f)
                                  ),),
                                  Text(" ${cubit.getFamilyMemberList[index]["national_id"]}"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("status :",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF800f2f)
                                  ),),
                                  Text(" ${cubit.getFamilyMemberList[index]["status"]}"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 250.0),
              child: AddFamilyMabmerButton(cubit:cubit,),
            ),
          ],
        );
      }
    );
  }
}