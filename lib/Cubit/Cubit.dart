import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/Cubit/States.dart';

class CounterCubit extends Cubit<CounterStates>{

  CounterCubit() : super(CounterInitialState()); // تمرير الحالة الأولية

int counter = 1;

static CounterCubit get(context)=> BlocProvider.of(context);

void counterPlus(){
  counter++;
  emit(CounterUpdatedState());
}

  void counterMinus(){
counter--;
emit(CounterUpdatedState());

  }


}