import 'package:flutter/material.dart';
import 'package:national/presentation/family/cubit/cubit.dart';
import '../../../utils/var/controllers.dart';
class AddFamilyMabmerButton extends StatelessWidget {
  const AddFamilyMabmerButton({super.key,required this.cubit});
  final FamilyCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 350.0,left: 20),
      child: InkWell(
        onTap: (){
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title:const Text("add new family member",style: TextStyle(
                    color: Color(0xFF800f2f),
                    fontWeight: FontWeight.bold,
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
                            child: Text("+"),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 60.0),
                        child: InkWell(
                          onTap: () async{
                            cubit.addNewFamilyMemberCubit({
                              "name":Controllers.userNameController.text,
                              "national_id":Controllers.nationalIdController.text,
                              "image": cubit.getimage!,
                              "massege":Controllers.massegeController.text,
                              "request_name":"add new family member",
                              "status":"in progress",
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
              )
          );

        },
        child: Container(
          alignment: Alignment.center,
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
            color: Color(0xFF800f2f),
              shape: BoxShape.circle,
          ),
          child:const Text("+",style: TextStyle(
            color: Colors.white,
          ),),
        ),
      ),
    );
  }
}