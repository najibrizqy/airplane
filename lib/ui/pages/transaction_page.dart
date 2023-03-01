import 'package:airplane/cubit/transaction_cubit.dart';
import 'package:airplane/shared/theme.dart';
import 'package:airplane/ui/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void initState() {
    context.read<TransactionCubit>().fetchTransaction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TransactionSuccess) {
          if (state.transaction.length == 0) {
            return Center(
              child: Text('Kamu belum memiliki transaksi'),
            );
          } else {
            return ListView.builder(
                itemCount: state.transaction.length,
                padding: EdgeInsets.only(
                  left: defaultMargin,
                  right: defaultMargin,
                  top: 30,
                  bottom: 120,
                ),
                itemBuilder: (context, index) {
                  return TransactionCard(state.transaction[index]);
                });
          }
        } else if (state is TransactionFailed) {
          return Center(child: Text(state.error));
        }

        return Center(
          child: Text('Transaction Page'),
        );
      },
    );
  }
}
