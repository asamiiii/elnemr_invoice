import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


// ignore: must_be_immutable
class DetailesAppBar extends StatelessWidget {
  String clientName;
   DetailesAppBar({super.key,required this.clientName});
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
          child: Text(clientName, maxLines: 1, softWrap: false,style:GoogleFonts.notoKufiArabic(),)),
    
    );
  }
}