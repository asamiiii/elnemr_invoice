import 'dart:io';
import 'package:flutter/cupertino.dart';
import '../../data/data_source/remot/firebase_manager.dart';

class AddInvoiceVM {




  Future<void> addInvoice(
      {BuildContext? context,
      File? image,
      String? imagePath,
      String? clientName,
      String? total,
      DateTime? date}) async {
    String imageUrl =
        await FirebaseHelper().uploadImageOnFirebaseStorage(image!, imagePath!);
    await FirebaseHelper().addTaskToFirebase(
      clientName: clientName ?? '',
      total: total ?? '',
      date: date!,
      imageUrl: imageUrl,
    );

    
    
    // ignore: use_build_context_synchronously

    debugPrint(imageUrl);
  }
}
