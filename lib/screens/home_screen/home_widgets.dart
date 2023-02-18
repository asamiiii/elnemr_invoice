import 'dart:io';
import 'package:elnemr_invoice/screens/add_invoice_screen/add_invoice_screen.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/colors.dart';
import '../../core/strings.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(50),
      )),
      flexibleSpace: Container(),
      title: Container(
          padding: const EdgeInsets.all(10),
          child: Text(AppStrings.appName, maxLines: 1, softWrap: false)),
      leading: IconButton(
        iconSize: 30,
        icon: ImageIcon(
          const AssetImage('assets/images/bill.png'),
          color: blackColor,
        ),
        onPressed: () async {
          final pickedFile = await ImagePicker().pickImage(
            source: ImageSource.camera,
            maxHeight: 400,
            maxWidth: 300,
            imageQuality: 50,
          );
          if (pickedFile != null) {
            final imageFile = File(pickedFile.path);
            debugPrint(p.basename(pickedFile.path));
            // ignore: use_build_context_synchronously
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddInoviceScreen(
                      image: imageFile, imagePath: p.basename(pickedFile.path)),
                ));
          } else {
            debugPrint('No image selected.');
          }
        },
      ),
      actions: [
        IconButton(
          iconSize: 30,
          icon: Icon(
            Icons.search,
            color: blackColor,
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
