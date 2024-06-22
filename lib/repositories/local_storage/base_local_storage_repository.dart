import 'package:hive/hive.dart';
import 'package:mypfeapp/home/models/actualite_model.dart';

abstract class BaseLocalStorageRepository {
  Future<Box> openBox();
  List<Actualite> getWishlist(Box box);
  Future<void> addProductToWishlist(Box box, Actualite product);
  Future<void> removeProductFromWishlist(Box box, Actualite product);
  Future<void> clearWishlist(Box box);
}
