import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionDetailsScreen extends StatefulWidget {
  final DocumentSnapshot transactionData;
  const TransactionDetailsScreen(this.transactionData, {Key? key})
      : super(key: key);

  @override
  State<TransactionDetailsScreen> createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {
  String formatTransactionDate(Timestamp timestamp) {
    final DateTime dateTime = timestamp.toDate();

    final DateFormat formatter = DateFormat('MMM. dd, HH:mm');

    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    var transactionCategory = widget.transactionData['transaction category'];

    var transactionAmount = widget.transactionData['transaction amount'];
    var transactionDate =
        formatTransactionDate(widget.transactionData['transaction date']);
    var transactionDateCreated = formatTransactionDate(
        widget.transactionData['transaction date created']);
    var transactionDesc = widget.transactionData['transaction description'];

    Icon getTransactionCategoryIcon(String category) {
      switch (category) {
        case 'Electronic':
          return const Icon(Icons.devices, color: Color(0xffEA5F89), size: 80);
        case 'Shopping':
          return const Icon(Icons.shopping_bag,
              color: Color(0xffF7B7A3), size: 80);
        case 'OtherExpenses':
          return const Icon(Icons.receipt_rounded,
              color: Color(0xff2b0b3f), size: 80);
        case 'Transportation':
          return const Icon(Icons.directions_car,
              color: Color(0xff9B3192), size: 80);
        case 'FoodandBeverage':
          return const Icon(Icons.fastfood, color: Color(0xff57167E), size: 80);
        default:
          return const Icon(Icons.settings_outlined,
              color: Color(0xFF57636C), size: 80);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
        backgroundColor: const Color(0xFF6D5FED),
      ),
      body: SafeArea(
        top: true,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/bg2.png"),
            fit: BoxFit.cover,
          )),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 600,
                  decoration: const BoxDecoration(
                    color: Color(0x00FFFFFF),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: const Color(0xFFFFFFFF),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child:
                              getTransactionCategoryIcon(transactionCategory),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: Text(
                          '$transactionCategory',
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                              color: Color(0xFFFFFFFF)),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: Text(
                          'Rs $transactionAmount',
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                              color: Color(0xFFE74852)),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(40, 0, 0, 0),
                              child: Text(
                                'Description',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                    color: Color(0xFFFFFFFF)),
                              ),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(81, 0, 0, 0),
                              child: Text(
                                ':',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                    color: Color(0xFFFFFFFF)),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.00, 0.00),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 0),
                                child: Text(
                                  '$transactionDesc',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0,
                                      color: Color(0xFFFFFFFF)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(40, 0, 0, 0),
                              child: Text(
                                'Transaction Made',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                    color: Color(0xFFFFFFFF)),
                              ),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(34, 0, 0, 0),
                              child: Text(
                                ':',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                    color: Color(0xFFFFFFFF)),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.00, 0.00),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 0),
                                child: Text(
                                  transactionDate,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0,
                                      color: Color(0xFFFFFFFF)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(40, 0, 0, 0),
                              child: Text(
                                'Transaction Created',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                    color: Color(0xFFFFFFFF)),
                              ),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
                              child: Text(
                                ':',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                    color: Color(0xFFFFFFFF)),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.00, 0.00),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 0),
                                child: Text(
                                  transactionDateCreated,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0,
                                      color: Color(0xFFFFFFFF)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
