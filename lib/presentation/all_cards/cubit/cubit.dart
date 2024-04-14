import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'state.dart';
import 'package:intl/intl.dart';
class AllCardsCubit extends Cubit<AllCardsMainState> {
  AllCardsCubit() : super(AllCardsInitState());
  String ? getimage;
  List getAllCardsList=[];
  List getAllCardsListId=[];
  static AllCardsCubit get(context) => BlocProvider.of(context);
  getAllCardsCubit()async{
    emit(GetEmptyState());
    await FirebaseFirestore.instance
        .collection("Profile")
        .doc(FirebaseAuth.instance.currentUser!.uid).collection("my_cards")
        .get().then((value){
          getAllCardsList=[];
          getAllCardsListId=[];
          value.docs.forEach((element) {
            getAllCardsList.add(element.data());
            getAllCardsListId.add(element.id);
          });
    });
    emit(GetAllCardsCubit());
  }

  addAllCardsImage(stats)async{
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      var formatter = new DateFormat('yyyy-MM-dd');
      var now = new DateTime.now();
      String formattedDate = formatter.format(now);
      if (result != null) {
        String fileName = result.files.first.path!;
        // Upload file
        final file=File(fileName);
        await FirebaseStorage.instance
            .ref('uploads/$formattedDate')
            .putFile(file);
        getimage = await FirebaseStorage.instance
            .ref('uploads/$formattedDate')
            .getDownloadURL();
        FirebaseFirestore.instance
            .collection("Profile")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("my_cards").doc(stats).collection("update").doc("update")
            .update({"image":getimage!});
      }
      emit(AddImageAllCardsState());
  }
  addUpdate(stats,Map<String,dynamic> data)async{
   await FirebaseFirestore.instance
        .collection("Profile")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("my_cards").doc(stats).collection("update").doc("update")
        .update(data);
    emit(UpadteCardsState());
  }
}