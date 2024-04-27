import 'package:flutter/material.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({super.key,required this.history});
  final List history;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics:const NeverScrollableScrollPhysics(),
        itemCount:history.length ,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("last check",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                  )),
                  Text(history[i]["history"],style: TextStyle(
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
