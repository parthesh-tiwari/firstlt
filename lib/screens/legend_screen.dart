import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Legendscreen extends StatefulWidget {
  const Legendscreen({super.key});

  @override
  State<Legendscreen> createState() => _LegendscreenState();
}

class _LegendscreenState extends State<Legendscreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference transactiondata =
      FirebaseFirestore.instance.collection('transactions');

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;

    return Scaffold(
      body: Material(
        color: Colors.transparent,
        elevation: 10,
        child: Container(
          width: double.infinity,
          height: 115,
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<Map<String, dynamic>>(
                  future: fetchTransactionTotals(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Widget> typeContainers = [];

                      if ((snapshot.data!['OtherExpenses'] ?? 0.0) > 0) {
                        typeContainers.add(buildTransactionContainer(
                            'Other expenses',
                            Icons.receipt_rounded,
                            snapshot.data!['OtherExpenses'] ?? 0.0,
                            iconColor: const Color(0xff4D6D5FED),
                            shadowColor: const Color(0xff4D6D5FED),
                            routeName: '/listotherexpenses'));
                      }

                      if ((snapshot.data!['Shopping'] ?? 0.0) > 0) {
                        typeContainers.add(buildTransactionContainer(
                            'Shopping',
                            Icons.shopping_bag,
                            snapshot.data!['Shopping'] ?? 0.0,
                            iconColor: const Color(0xff39D2C0),
                            shadowColor: const Color(0xff39D2C0),
                            routeName: '/listshopping'));
                      }

                      if ((snapshot.data!['Electronic'] ?? 0.0) > 0) {
                        typeContainers.add(buildTransactionContainer(
                            'Electronic',
                            Icons.devices,
                            snapshot.data!['Electronic'] ?? 0.0,
                            iconColor: const Color(0xff6D5FED),
                            shadowColor: const Color(0xff6D5FED),
                            routeName: '/listelectronic'));
                      }

                      if ((snapshot.data!['Transportation'] ?? 0.0) > 0) {
                        typeContainers.add(buildTransactionContainer(
                            'Transportation',
                            Icons.directions_car,
                            snapshot.data!['Transportation'] ?? 0.0,
                            iconColor: const Color(0xffE74852),
                            shadowColor: const Color(0xffE74852),
                            routeName: '/listtransportation'));
                      }

                      if ((snapshot.data!['FoodandBeverage'] ?? 0.0) > 0) {
                        typeContainers.add(buildTransactionContainer(
                            'Food & Beverage',
                            Icons.fastfood,
                            snapshot.data!['FoodandBeverage'] ?? 0.0,
                            iconColor: const Color(0xffFF6D33),
                            shadowColor: const Color(0xffFF6D33),
                            routeName: '/listfoodandbeverage'));
                      }

                      return Row(
                        children: typeContainers,
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> fetchTransactionTotals() async {
    Map<String, dynamic> totalsMap = {};

    List<String> transactionTypes = [
      'OtherExpenses',
      'Shopping',
      'Electronic',
      'Transportation',
      'FoodandBeverage',
    ];

    for (String type in transactionTypes) {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await transactiondata
          .where('email', isEqualTo: auth.currentUser?.email)
          .where('transaction category', isEqualTo: type)
          .get() as QuerySnapshot<Map<String, dynamic>>;

      double total = 0.0;
      for (QueryDocumentSnapshot<Map<String, dynamic>> document
          in querySnapshot.docs) {
        double amount =
            double.tryParse(document['transaction amount'] ?? '0.0') ?? 0.0;
        total += amount;
      }

      totalsMap[type] = total;
    }

    return totalsMap;
  }

  Widget buildTransactionContainer(String title, IconData icon, double amount,
      {required Color iconColor,
      required Color shadowColor,
      required String routeName}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Container(
        width: 110,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        alignment: const AlignmentDirectional(0.00, 0.00),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: const Color(0xFFFFFFFF),
                elevation: 4,
                shadowColor: shadowColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 24,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 7, 0, 2),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                    color: Color(0xFF101213),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
                child: Text(
                  '- Rs ${amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 12.0,
                    color: Color(0xFFE74852),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
