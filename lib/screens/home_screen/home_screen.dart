import 'package:elnemr_invoice/core/strings.dart';
import 'package:elnemr_invoice/data/data_source/remot/firebase_manager.dart';
import 'package:elnemr_invoice/screens/detailes_screen/detailes_screen.dart';
import 'package:flutter/material.dart';
import 'home_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 100,
      onRefresh: () async {
        setState(() {});
      },
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: HomeAppBar(),
        ),
        body: StreamBuilder(
            stream: FirebaseHelper().getInvoicesFromFirestore(),
            builder: (context, snapshot) {
              var list = snapshot.data?.docs;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (list!.isEmpty) {
                return Center(child: Text(AppStrings.noInvoiceExist));
              } else if (snapshot.hasError) {
                return Center(child: Text(AppStrings.hasErrorMessage));
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListView.separated(
                    itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                DetailesScreen(invoice: list[index].data()),
                          ));
                        },
                        child: InvoiceItem(list[index].data())),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 5),
                    itemCount: list.length),
              );
            }),
      ),
    );
  }
}
