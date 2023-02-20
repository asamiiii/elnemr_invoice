// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/colors.dart';

class ImageFromLocal extends StatelessWidget {
  final File file;
   const ImageFromLocal({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(
                  file,
                  //width: MediaQuery.of(context).size.width * 0.90,
                  height: MediaQuery.of(context).size.height * 0.65,
                  fit: BoxFit.fill,
                ),
              );
  }
}

// ignore: must_be_immutable
class ImageFromCloud extends StatelessWidget {
  String url;
  double hight;
  double width;
  ImageFromCloud({
    Key? key,
    required this.url,
    required this.hight,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/giphy.gif',
                    image: url,
                    width: width,
                    height: hight,
                    fit: BoxFit.fill,
                  ),
                );
  }
}

// ignore: must_be_immutable
class TotalContainer extends StatelessWidget {
  String total;
  TotalContainer({
    Key? key,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
              margin: const EdgeInsets.only(right: 10, left: 10),
              width: 140,
              height: 50,
              decoration: BoxDecoration(
                  color: blackColor, borderRadius: BorderRadius.circular(10)),
              child: Center(child: Text('حساب : $totalج',style:Theme.of(context).textTheme.headline2?.copyWith(color:whiteColor,overflow: TextOverflow.ellipsis ),textDirection: ui.TextDirection.rtl,)),
            );
  }
}

// ignore: must_be_immutable
class AppTextField extends StatelessWidget {
  TextEditingController controller =TextEditingController();
  TextInputType keyboardType;
  Widget icon;
  String hintText;
  int maxLines;
  AppTextField({
    Key? key,
    this.maxLines=1,
    required this.controller,
    required this.keyboardType,
    required this.icon,
    required this.hintText,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
                        controller: controller,
                        maxLines: maxLines,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        textDirection: TextDirection.rtl,
                        keyboardType: keyboardType,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10.0),
                          filled: true,
                          fillColor: whiteColor,
                          prefixIcon: icon,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          hintText: hintText,
                          hintTextDirection: TextDirection.rtl,
                          hintStyle: GoogleFonts.notoKufiArabic(
                            color: Colors.black,
                          ),
                  
                          //labelStyle: TextStyle(color: blackColor)),
                        ));
  }
}

showSnakBarSuccess(BuildContext context,String message ,Color color) {
    final snackBar = SnackBar(
      backgroundColor: color,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style:Theme.of(context).textTheme.headline2,
          ),
        ],
      ),
      action: SnackBarAction(
        textColor: whiteColor,
        label: 'ok',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showLoading(BuildContext context, String message,
      {bool isCancellable = true}) {
    return showDialog(
      context: context,
      barrierDismissible: isCancellable,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Text(message),
              const SizedBox(
                width: 15,
              ),
              const CircularProgressIndicator()
            ],
          ),
        );
      },
    );
  }

  hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }