import 'package:flutter/material.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics:const NeverScrollableScrollPhysics(),
        itemCount: 6,
        shrinkWrap: true,
        itemBuilder: (c,i){
          return  Padding(
            padding: const EdgeInsets.only( left: 50.0,top: 20),
            child: Row(children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200
                ),
              ),
              SizedBox(width: 20,),
              Column(
                children: [
                  const Text("last check",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                  )),
                  Text("28/10/2014",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.grey.shade400
                  )),
                ],
              ),
            ],),
          );
        });

  }
}
