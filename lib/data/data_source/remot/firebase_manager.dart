import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart';

import '../../models/user_model.dart';

class FirebaseHelper {
  CollectionReference getInvoiceCollection() {
    return FirebaseFirestore.instance
        .collection('invoice')
        .withConverter<Invoice>(
          fromFirestore: (snapshot, _) => Invoice.fromJson(snapshot.data()!),
          toFirestore: (task, _) => task.toJson(),
        );
  }

  Future<void> addTaskToFirebase(
      {String? id,
      required String clientName,
      required String total,
      required String imageUrl,
      required DateTime date}) async {
    var collection = getInvoiceCollection();
    var docRef = collection.doc();
    return await docRef.set(Invoice(
        id: docRef.id,
        name: clientName,
        total: total,
        imageUrl: imageUrl,
        date: date));
  }

  Future<String> uploadImageOnFirebaseStorage(
      File imageFile, String path) async {
    String? url;
// Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();
// Create a reference to "mountains.jpg"
    final mountainsRef = storageRef.child(p.basename(path));

    try {
      await mountainsRef.putFile(imageFile);
      url = await mountainsRef.getDownloadURL();
    } catch (e) {
      //
    }
    return url ?? '';
  }

   Future<List<Invoice?>> getInvoicesFromFirestore() async{
    
    QuerySnapshot<Invoice> querySnapshot=await getInvoiceCollection().get() as QuerySnapshot<Invoice>;
    // Get data from docs and convert map to List
    var allData = querySnapshot.docs.map((doc) => doc.data()).toList() ;
    debugPrint('$allData');
    return allData;
         
  }
}
