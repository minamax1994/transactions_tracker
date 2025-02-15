// Mocks generated by Mockito 5.4.5 from annotations
// in transactions_tracker/test/domain/use_cases/get_cards_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:transactions_tracker/core/error/failures.dart' as _i5;
import 'package:transactions_tracker/domain/entities/card.dart' as _i6;
import 'package:transactions_tracker/domain/repositories/card_repository.dart'
    as _i3;
import 'package:transactions_tracker/domain/use_cases/create_card.dart' as _i7;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CardRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCardRepository extends _i1.Mock implements _i3.CardRepository {
  MockCardRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.CardEntity>> createCard(
          _i7.CardParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #createCard,
          [params],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.CardEntity>>.value(
            _FakeEither_0<_i5.Failure, _i6.CardEntity>(
          this,
          Invocation.method(
            #createCard,
            [params],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.CardEntity>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.CardEntity>>> getCards() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCards,
          [],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i6.CardEntity>>>.value(
                _FakeEither_0<_i5.Failure, List<_i6.CardEntity>>(
          this,
          Invocation.method(
            #getCards,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.CardEntity>>>);
}
