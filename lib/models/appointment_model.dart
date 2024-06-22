import 'dart:convert';

import 'package:mypfeapp/models/delivery_time_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Appointment extends Equatable {
  final String? id;
  final String userId;

  final double total;
  final String productId;
  final bool isAccepted;
  final bool isDelivered;
  final bool isCancelled;

  final DateTime createdAt;
  final String time;
  const Appointment(
      {this.id,
      required this.userId,
      required this.productId,
      required this.time,
      // required this.customerId,
      // required this.productIds,
      // required this.deliveryFee,
      // required this.subtotal,
      required this.total,
      required this.isAccepted,
      required this.isDelivered,
      required this.createdAt,
      required this.isCancelled});
  @override
  List<Object?> get props => [
        id,
        productId,
        total,
        isAccepted,
        isDelivered,
        createdAt,
        isCancelled,
        time,
        userId
      ];
  Appointment copyWith(
      {String? id,
      String? userId,
      String? prouctId,
      double? total,
      String? time,
      bool? isAccepted,
      bool? isDelivered,
      DateTime? createdAt,
      bool? isCancelled}) {
    return Appointment(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      time: time ?? this.time,
      productId: productId,
      total: total ?? this.total,
      isAccepted: isAccepted ?? this.isAccepted,
      isDelivered: isDelivered ?? this.isDelivered,
      isCancelled: isCancelled ?? this.isCancelled,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, Object> toDocument() {
    return {
      // 'id': id,
      'userId': userId,
      'time': time,
      'productId': productId,
      'total': total,
      'isAccepted': isAccepted,
      'isDelivered': isDelivered,
      'isCancelled': isCancelled,
      'createdAt': createdAt.millisecondsSinceEpoch
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'productId': productId,
      'total': total,
      'isAccepted': isAccepted,
      'isDelivered': isDelivered,
      'isCancelled': isCancelled,
      'createdAt': createdAt.millisecondsSinceEpoch
    };
  }

  factory Appointment.fromSnapshot(DocumentSnapshot snap) {
    return Appointment(
      id: snap.id,
      userId: snap['userId'],

      time: snap['time'],
      productId: snap['productId'],
      total: snap['total'],
      isDelivered: snap['isDelivered'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(snap['createdAt']),
      //.toDate(), //DateTime.fromMillisecondsSinceEpoch(snap['createdAt']),
      //DateTime.fromMillisecondsSinceEpoch(msIntFromServer)
      isAccepted: snap['isAccepted'],
      isCancelled: snap['isCancelled'],
    );
  }
  String toJson() => json.encode(toMap());

  // static List<Order> orders = [
  //   Order(
  //     id: 1,
  //     customerId: 1,
  //     productIds: [1, 2, 3],
  //     deliveryFee: 10,
  //     subtotal: 30,
  //     total: 40,
  //     isAccepted: false,
  //     isDelivered: false,
  //     isCancelled: false,
  //     createdAt: DateTime.now(),
  //   ),
  //   Order(
  //     id: 2,
  //     isCancelled: false,
  //     customerId: 2,
  //     productIds: [1, 2, 3],
  //     deliveryFee: 10,
  //     subtotal: 20,
  //     total: 30,
  //     isAccepted: true,
  //     isDelivered: false,
  //     createdAt: DateTime.now(),
  //   ),
  //   Order(
  //     id: 3,
  //     customerId: 3,
  //     isCancelled: true,
  //     productIds: [1, 2, 3],
  //     deliveryFee: 10,
  //     subtotal: 26,
  //     total: 36,
  //     isAccepted: true,
  //     isDelivered: true,
  //     createdAt: DateTime.now(),
  //   ),
  //   Order(
  //     id: 4,
  //     customerId: 4,
  //     isCancelled: true,
  //     productIds: [1, 2, 3],
  //     deliveryFee: 10,
  //     subtotal: 10,
  //     total: 20,
  //     isAccepted: true,
  //     isDelivered: true,
  //     createdAt: DateTime.now(),
  //   ),
  //   Order(
  //     id: 5,
  //     customerId: 5,
  //     productIds: [1, 2, 3],
  //     deliveryFee: 10,
  //     subtotal: 35,
  //     isCancelled: true,
  //     total: 45,
  //     isAccepted: true,
  //     isDelivered: true,
  //     createdAt: DateTime.now(),
  //   ),
  // ];
}
