import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jzeno_tea/app/data/bloc/topping/topping_state.dart';
import 'package:jzeno_tea/app/data/repository/repository.dart';
import 'package:jzeno_tea/app/model/topping_model.dart';

class ToppingCubit extends Cubit<ToppingState>{
  ToppingCubit():super(ToppingLoading()){
    fetchToppings();
  }
  
   APIRepository repo = APIRepository();
  void fetchToppings() async {
    try {
      List<ToppingModel> toppings = await repo.fetchListTopping();
      emit(ToppingsLoaded(toppings));
    } catch (ex) {
      emit(ToppingError(ex.toString()));
    }
  }
}