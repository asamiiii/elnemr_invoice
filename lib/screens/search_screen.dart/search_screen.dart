import 'package:elnemr_invoice/data/data_source/remot/firebase_manager.dart';
import 'package:elnemr_invoice/screens/detailes_screen/detailes_screen.dart';
import 'package:elnemr_invoice/screens/home_screen/home_widgets.dart';
import 'package:flutter/material.dart';

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
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onChanged: (value) async {
                      setState(() {});
                    },
                    controller: searchController,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        border: const OutlineInputBorder(),
                        hintText: 'البحث',
                        hintStyle: const TextStyle(color: Colors.grey),
                        labelText: 'البحث',
                        labelStyle: TextStyle(color: blackColor)),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                TextButton.icon(
                    onPressed: () {
                      searchController.clear();
                    },
                    icon: const Icon(Icons.clear_all),
                    label: const Text('حذف البحث'))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
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
                      itemBuilder: (context, index) =>
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailesScreen(invoice: invoices?[index].data()),));
                            },
                            child: InvoiceItem(invoices?[index].data())),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: searchController.text=='' ? 0 : invoices!.length,
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
