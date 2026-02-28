import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Cas d'usage pour l'inscription bachelier
class RegisterBachelierUseCase
    implements UseCase<User, RegisterBachelierParams> {
  final AuthRepository repository;

  RegisterBachelierUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(RegisterBachelierParams params) async {
    return await repository.registerBachelier(
      nom: params.nom,
      prenom: params.prenom,
      email: params.email,
      motDePasse: params.motDePasse,
      telephone: params.telephone,
    );
  }
}

class RegisterBachelierParams extends Equatable {
  final String nom;
  final String prenom;
  final String email;
  final String motDePasse;
  final String telephone;

  const RegisterBachelierParams({
    required this.nom,
    required this.prenom,
    required this.email,
    required this.motDePasse,
    required this.telephone,
  });

  @override
  List<Object> get props => [nom, prenom, email, motDePasse, telephone];
}
