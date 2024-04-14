import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'state.dart';
import 'package:intl/intl.dart';
class FamilyCubit extends Cubit<FamilyMainState> {
  FamilyCubit() : super(FamilyInitState());
  String ? getimage;
  List getFamilyMemberList=[];
  List getFamilyMemberListId=[];
  static FamilyCubit get(context) => BlocProvider.of(context);
  getFamilyMemberCubit()async{
    emit(GetEmptyState());
    await FirebaseFirestore.instance
        .collection("Profile")
        .doc(FirebaseAuth.instance.currentUser!.uid).collection("my_family")
        .get().then((value){
          getFamilyMemberList=[];
          getFamilyMemberListId=[];
          value.docs.forEach((element) {
            getFamilyMemberList.add(element.data());
            getFamilyMemberListId.add(element.id);
          });
    });
    emit(GetFamilyMemberCubit());
  }
  addNewFamilyMemberCubit(data){
    FirebaseFirestore.instance
        .collection("Profile")
        .doc(FirebaseAuth.instance.currentUser!.uid).collection("my_family")
        .add(data);
    FirebaseFirestore.instance
        .collection("Profile")
        .doc(FirebaseAuth.instance.currentUser!.uid).collection("my_family")
        .add(data);
    emit(AddFamilyMemberState());
  }
  updateFamilyMemberCubit(data,id)async{
    await FirebaseFirestore.instance
        .collection("Profile")
        .doc(FirebaseAuth.instance.currentUser!.uid).collection("my_family_update").doc(id)
        .set({});
    FirebaseFirestore.instance
        .collection("Profile")
        .doc(FirebaseAuth.instance.currentUser!.uid).collection("my_family_update").doc(id)
        .update(data);
    emit(UpdateFamilyMemberState());
  }

  addFamilyImage()async{
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
      //   FirebaseFirestore.instance
      //       .collection("Profile")
      //       .doc(FirebaseAuth.instance.currentUser!.uid).collection("my_family")
      //       .add(data);
      }
      emit(AddImageMyFamilyState());
  }
}