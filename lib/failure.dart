sealed class Failure {
  final String message = "";
  const Failure();
}


class EmailTakenFailure extends Failure {
  final String message = "This email is already used";
}


class GeneralFailure extends Failure {
  final String message = "Something went wrong";
}