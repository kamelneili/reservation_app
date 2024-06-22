import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mypfeapp/home/models/actualite_model.dart';
import 'package:mypfeapp/models/appointment_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SearchRepository {
  final FirebaseFirestore _firebaseFirestore;

  SearchRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Actualite>> fetchSearchedProduct(String searchQuery) {
    return _firebaseFirestore
        .collection('actualites')
        .where('nbrperson', isEqualTo: searchQuery)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Actualite.fromSnapshot(doc)).toList();
    });
  }
}
