sealed class ResultAPI<T> {}

class SuccessAPI<T> extends ResultAPI<T> {
  SuccessAPI({this.data});
  T? data;
}

class ErrorAPI<T> extends ResultAPI<T> {
  ErrorAPI({required this.messageError});
  String messageError;

}