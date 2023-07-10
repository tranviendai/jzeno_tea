import 'package:jzeno_tea/app/model/topping_model.dart';

abstract class ToppingState {}

class ToppingLoading extends ToppingState {}

class ToppingsLoaded extends ToppingState{
  final List<ToppingModel> toppings;
  ToppingsLoaded(this.toppings);
}

class ToppingError extends ToppingState{
  final String? message;
  ToppingError(this.message);
}
