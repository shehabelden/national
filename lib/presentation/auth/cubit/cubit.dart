import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'state.dart';
class AuthCubit extends Cubit<AuthMainState> {
  AuthCubit() : super(AuthInitState());
  static AuthCubit get(context) => BlocProvider.of(context);
  bool hidePasse=false;
  hidePass(){
    hidePasse=!hidePasse;
    emit(HidePasswordState());
  }
  signInCubit(emailAddress, password) async {
    emit(EmptyLoginState());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: "$emailAddress@gmail.com", password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    emit(SignInState());
  }

  signUpCubit(emailAddress, password,name) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: "$emailAddress@gmail.com",
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    print("e");
    createProfile(FirebaseAuth.instance.currentUser!.uid,name,emailAddress);
    emit(SignUpState());
  }
  createProfile(uid,name,emailAddress)async{
   await FirebaseFirestore.instance.collection("Profile").doc(uid).set(
     {
       "name":name,
       "national_id":emailAddress,
     }
   );
   FirebaseFirestore.instance.
   collection("Profile").doc(uid).collection("my_cards").doc("national_card").set({
     "name":"national card",
     "request_name":"add national card",
     "permission":"Ministry of Interior",
     "status":"pending",
   });
   FirebaseFirestore.instance.
   collection("Profile").doc(uid).collection("my_cards").doc("Insurance").set({
     "name":"Insurance",
     "request_name":"add Insurance",
     "permission":"Insurance",
     "status":"pending",
   });
   FirebaseFirestore.instance.
   collection("Profile").doc(uid).collection("my_cards").doc("driving_license").set({
     "name":"driving license",
     "request_name":"add driving license",
     "permission":"the traffic",
     "status":"pending",
   });
   FirebaseFirestore.instance.
   collection("Profile").doc(uid).collection("my_cards").doc("national_card").collection("update").doc("update").set({
     "request_name":"update national_card",
     "status":"pending",
   });
   FirebaseFirestore.instance.
   collection("Profile").doc(uid).collection("my_cards").doc("Insurance").collection("update").doc("update").set({
     "request_name":"update Insurance",
     "status":"pending",
   });
   FirebaseFirestore.instance.
   collection("Profile").doc(uid).collection("my_cards").doc("driving_license").collection("update").doc("update").set({
     "request_name":"update driving_license",
     "status":"pending",
   });

   FirebaseFirestore.instance.
   collection("Profile").doc(uid).collection("my_family").add({});
  }
}
