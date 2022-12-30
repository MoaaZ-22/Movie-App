import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../error/failure.dart';

abstract class BaseUseCase<T, Parameters> {
  /// T refers To any Type You Will Decide
  Future<Either<Failure, T>> call(Parameters parameters);
}

class NoParameters extends Equatable {
  const NoParameters();

  @override
  List<Object> get props => [];
}