import 'package:dartz/dartz.dart';
import '../error/failures.dart';

/// Classe de base pour tous les cas d'usage
/// [Type] est le type de retour
/// [Params] est le type des paramètres d'entrée
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Utilisé quand un cas d'usage ne nécessite aucun paramètre
class NoParams {
  const NoParams();
}
