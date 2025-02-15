import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:transactions_tracker/domain/use_cases/get_cards.dart';
import 'package:uuid/uuid.dart';

import '../../data/data_sources/local/card_local_data_source.dart';
import '../../data/data_sources/local/transaction_local_data_source.dart';
import '../../data/data_sources/remote/transaction_remote_data_source.dart';
import '../../data/models/card_model.dart';
import '../../data/models/transaction_model.dart';
import '../../data/repositories/card_repository_impl.dart';
import '../../data/repositories/transaction_repository_impl.dart';
import '../../domain/repositories/card_repository.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../domain/use_cases/create_card.dart';
import '../../domain/use_cases/get_transaction.dart';
import '../../domain/use_cases/get_transactions.dart';
import '../../presentation/bloc/card/card_cubit.dart';
import '../../presentation/bloc/cards/cards_cubit.dart';
import '../../presentation/bloc/transaction/transaction_cubit.dart';
import '../../presentation/bloc/transactions/transactions_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionModelAdapter());
  Hive.registerAdapter(CardModelAdapter());

  final transactionBox = await Hive.openBox<TransactionModel>('transactions');
  final cardBox = await Hive.openBox<CardModel>('cards');

  final internetConnectionChecker = InternetConnectionChecker.instance;

  // Bloc/Cubit
  sl.registerFactory(() => TransactionsCubit(getTransactions: sl()));
  sl.registerFactory(() => TransactionCubit(getTransaction: sl()));
  sl.registerFactory(() => CardsCubit(getCards: sl()));
  sl.registerFactory(() => CardCubit(createCard: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetTransactions(sl()));
  sl.registerLazySingleton(() => GetTransaction(sl()));
  sl.registerLazySingleton(() => GetCards(sl()));
  sl.registerLazySingleton(() => CreateCard(sl()));

  // Repositories
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      connectionChecker: sl(),
    ),
  );

  sl.registerLazySingleton<CardRepository>(
    () => CardRepositoryImpl(
      localDataSource: sl(),
      uuid: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<TransactionRemoteDataSource>(
    () => TransactionRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<TransactionLocalDataSource>(
    () => TransactionLocalDataSourceImpl(transactionBox: transactionBox),
  );

  sl.registerLazySingleton<CardLocalDataSource>(
    () => CardLocalDataSourceImpl(cardBox: cardBox),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Uuid());
  sl.registerLazySingleton(() => internetConnectionChecker);
  sl.registerLazySingleton(() => transactionBox);
  sl.registerLazySingleton(() => cardBox);
}
