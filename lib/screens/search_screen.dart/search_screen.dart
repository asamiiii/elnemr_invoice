import 'package:elnemr_invoice/data/data_source/remot/firebase_manager.dart';
import 'package:elnemr_invoice/screens/detailes_screen/detailes_screen.dart';
import 'package:elnemr_invoice/screens/home_screen/home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/colors.dart';

// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  String searchWord = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
              centerTitle: true,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(50),
              )),
              flexibleSpace: Container(),
              title: Container(
                  height: 55,
                  padding: const EdgeInsets.only(top: 7),
                  child: TextFormField(
                      onChanged: (value) {
                        setState(() {});
                      },
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
                      ))))),
      body: Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 10, right: 10),
          child: Expanded(
            child: FutureBuilder(
                future: FirebaseHelper()
                    .seaechInvoicesFromFirestore(searchController.text),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.data?.docs == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  var invoices = snapshot.data?.docs;
                  return ListView.separated(
                    itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailesScreen(
                                invoice: invoices?[index].data()),
                          ));
                        },
                        child: InvoiceItem(invoices?[index].data())),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount:
                        searchController.text == '' ? 0 : invoices!.length,
                  );
                }),
          )),
    );
  }
}
