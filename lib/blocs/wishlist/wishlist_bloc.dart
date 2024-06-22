import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mypfeapp/home/models/actualite_model.dart';
import 'package:mypfeapp/models/wishlist_model.dart';
import 'package:mypfeapp/repositories/local_storage/local_storage_repository.dart';
import '/models/models.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final LocalStorageRepository _localStorageRepository;

  WishlistBloc({required LocalStorageRepository localStorageRepository})
      : _localStorageRepository = localStorageRepository,
        super(WishlistLoading()) {
    on<StartWishlist>(_onStartWishlist);
    on<AddProductToWishlist>(_onAddProductToWishlist);
    on<RemoveProductFromWishlist>(_onRemoveProductFromWishlist);
  }

  void _onStartWishlist(
    StartWishlist event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoading());
    try {
      Box box = await _localStorageRepository.openBox();
      List<Actualite> products = _localStorageRepository.getWishlist(box);
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(
        WishlistLoaded(
          wishlist: Wishlist(actualites: products),
        ),
      );
    } catch (_) {
      emit(WishlistError());
    }
  }

  void _onAddProductToWishlist(
    AddProductToWishlist event,
    Emitter<WishlistState> emit,
  ) async {
    try {
      Box box = await _localStorageRepository.openBox();
      _localStorageRepository.addProductToWishlist(box, event.product);
      print("box");
      print(box);
      // emit(
      //   WishlistLoaded(
      //     wishlist: Wishlist(
      //       actualites: wishlist.actualites)
      //         ..add(event.product),
      //     ),
      //   ),
    } on Exception {
      emit(WishlistError());
    }
  }

  void _onRemoveProductFromWishlist(
    RemoveProductFromWishlist event,
    Emitter<WishlistState> emit,
  ) async {
    if (state is WishlistLoaded) {
      try {
        Box box = await _localStorageRepository.openBox();
        _localStorageRepository.removeProductFromWishlist(box, event.product);

        emit(
          WishlistLoaded(
            wishlist: Wishlist(
              actualites:
                  List.from((state as WishlistLoaded).wishlist.actualites)
                    ..remove(event.product),
            ),
          ),
        );
      } on Exception {
        emit(WishlistError());
      }
    }
  }
}
