import 'package:hive/hive.dart';
import 'package:mypfeapp/home/models/actualite_model.dart';
import 'package:mypfeapp/repositories/local_storage/base_local_storage_repository.dart';

import '/repositories/repositories.dart';
import '/models/models.dart';

class LocalStorageRepository extends BaseLocalStorageRepository {
  String boxName = 'wishlist_products';
  Type boxType = Actualite;

  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<Actualite>(boxName);
    return box;
  }

  @override
  List<Actualite> getWishlist(Box box) {
    return box.values.toList() as List<Actualite>;
  }

  @override
  Future<void> addProductToWishlist(Box box, Actualite product) async {
    await box.put(product.id, product);
  }

  @override
  Future<void> removeProductFromWishlist(Box box, Actualite product) async {
    await box.delete(product.id);
  }

  @override
  Future<void> clearWishlist(Box box) async {
    await box.clear();
  }
}
