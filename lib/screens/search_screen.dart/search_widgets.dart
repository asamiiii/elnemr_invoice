import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/colors.dart';

// ignore: must_be_immutable
class SearchAppBar extends StatelessWidget {
  SearchAppBar({super.key});

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(50),
        )),
        flexibleSpace: Container(),
        title: Container(
            height: 55,
            padding: const EdgeInsets.only(top: 20),
            child: TextFormField(
              
                controller: searchController,
                style: const TextStyle(
                  fontSize: 20,
                ),
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  filled: true,
                  fillColor: whiteColor,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: 'البحث',
                  hintTextDirection: TextDirection.rtl,
                  hintStyle: GoogleFonts.notoKufiArabic(
                    color: Colors.black,
                    
                  ),

                  //labelStyle: TextStyle(color: blackColor)),
                ))));
  }
}
