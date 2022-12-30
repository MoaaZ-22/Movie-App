import 'package:equatable/equatable.dart';

class MovieCast extends Equatable {
  final int id;
  final String? profilePath;
  final String name;

  const MovieCast(
      {required this.id,this.profilePath, required this.name});

  @override
  List<Object?> get props => [id, profilePath, name];
}
