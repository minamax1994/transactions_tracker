import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection.dart' as di;
import 'presentation/bloc/card/card_cubit.dart';
import 'presentation/bloc/cards/cards_cubit.dart';
import 'presentation/bloc/transaction/transaction_cubit.dart';
import 'presentation/bloc/transactions/transactions_cubit.dart';
import 'presentation/pages/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<CardsCubit>()),
        BlocProvider(create: (_) => di.sl<CardCubit>()),
        BlocProvider(create: (_) => di.sl<TransactionsCubit>()),
        BlocProvider(create: (_) => di.sl<TransactionCubit>()),
      ],
      child: MaterialApp(
        title: 'Transactions Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomePage(),
      ),
    );
  }
}
