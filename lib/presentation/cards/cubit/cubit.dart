import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'state.dart';
import 'package:intl/intl.dart';
class CardsCubit extends Cubit<CardMainState> {
  CardsCubit() : super(CardInitState());
  String ? getimage;
  Map profileMap={};
  List cardsList=[];
  List requetList=[];
  int index=0;
  static CardsCubit get(context) => BlocProvider.of(context);
  getMyDataCubit()async{
   await FirebaseFirestore.instance.collection("Profile").
    doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      profileMap=value.data()!;
    });
    emit(AddCardsState());
  }
  requestListCubit()async{
    emit(EmptyState());
    await FirebaseFirestore.instance.collection("Profile").
    doc(FirebaseAuth.instance.currentUser!.uid).collection("rejected").get().then((value) {
      value.docs.forEach((element) {
        requetList.add(element.data());
      });
    });
    emit(RequestState());
  }

  addCardImage(name)async{
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
            .doc(FirebaseAuth.instance.currentUser!.uid).collection("my_cards").doc(name).update({
          "image": getimage!,
          "status":"pending",
        });
      }
      emit(AddImageCardsState());
  }
  getAllCards()async{
    emit(EmptyAll());
  await  FirebaseFirestore.instance
        .collection("Profile")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("my_cards")
        .get().then((value) {
          cardsList=[];
          value.docs.forEach((element) {
            cardsList.add(element.data());
          });
    });
    emit(GetAllCardsState());
  }
  getCard(stats)async{
    await  FirebaseFirestore.instance
        .collection("Profile")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("my_cards").doc(stats)
        .get().then((value) {
    });
    emit(GetCardState());
  }
  getNum(i){
    index=i;
    emit(NumState());

  }
}