import 'package:equatable/equatable.dart';

import 'package:mypfeapp/models/delivery_time_model.dart';

class Basket extends Equatable {
  final DeliveryTime? deliveryTime;
  final DateTime? date;
  const Basket({
    this.deliveryTime,
    this.date,
  });
  Basket copyWith({DeliveryTime? deliveryTime, DateTime? date}) {
    return Basket(
      deliveryTime: deliveryTime ?? this.deliveryTime,
      date: date,
    );
  }

  @override
  List<Object?> get props => [deliveryTime];
  Map itemQuantity(items) {
    var quantity = {};
    items.forEach((item) {
      if (!quantity.containsKey(item)) {
        quantity[item] = 1;
      } else {
        quantity[item] += 1;
      }
    });
    return quantity;
  }
}
