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
      required String notes,
      required bool isDelivered,
      required DateTime date}) async {
    var collection = getInvoiceCollection();
    var docRef = collection.doc();
    return await docRef.set(Invoice(
        id: docRef.id,
        name: clientName,
        total: total,
        imageUrl: imageUrl,
        isDelivered: isDelivered,
        notes: notes,

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

  Stream<QuerySnapshot<Invoice?>> getInvoicesFromFirestore() {
    Stream<QuerySnapshot<Invoice?>> querySnapshot =
        getInvoiceCollection().orderBy('date',descending: true).snapshots() as Stream<QuerySnapshot<Invoice?>>;
    // Get data from docs and convert map to List

    return querySnapshot;
  }

  Future<QuerySnapshot<Invoice>> seaechInvoicesFromFirestore(
     String searchWord) async {
    QuerySnapshot<Invoice> querySnapshot= await getInvoiceCollection()
        .where('name', isGreaterThanOrEqualTo: searchWord)
        .get() as QuerySnapshot<Invoice>;
    // Get data from docs and convert map to List
    return querySnapshot;
    }
    
  

  Future<void> deleteUser(String? taskId, String url) {
    var collection = getInvoiceCollection();
    var docRef = collection.doc(taskId);
    deleteImageFromCloud(url);
    return docRef
        .delete()
        .then((value) => debugPrint("User Deleted"))
        .catchError((error) => debugPrint("Failed to delete user: $error"));
  }

  deleteImageFromCloud(String url) {
    FirebaseStorage.instance.refFromURL(url).delete();
  }

  Future<void> updateTask(String taskId,Invoice invoice) {
  var collection = getInvoiceCollection();
  var docRef=collection.doc(taskId);
  return docRef.update({
      'name': invoice.name,
      'total': invoice.total,
      'imageUrl':invoice.imageUrl,
      'notes':invoice.notes,
      'isDelivered':invoice.isDelivered,
  });
    }
}
