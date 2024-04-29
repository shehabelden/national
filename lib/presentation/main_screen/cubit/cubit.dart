import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:national/presentation/request/RequestScreen.dart';

import '../../Notifications/new_screen.dart';
import '../../cards/card_screen.dart';
import '../../family/family_screen.dart';
import 'state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(InitState());

  static MainCubit get(context) => BlocProvider.of(context);
  List screens=[
    CardScreen(),
    FamilyScreen(),
    RequestScreen(),
    NewScreen()
  ];
  int index=0;
  screenCubit(i){
    index=i;
    emit(BottomNavigate());
  }
}