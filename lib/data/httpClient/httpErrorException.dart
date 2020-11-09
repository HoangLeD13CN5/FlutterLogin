class HttpMethodError extends Error {
  final String message;
  HttpMethodError(this.message);
  String toString() => "HttpMethod Error: $message";
}

class HttpErrorResult extends Error {
  String message;
  String url;
  int status;
  String information_link = "";
  String details = "";
  HttpErrorResult({this.message,this.url,this.status});
  HttpErrorResult.fromJson({this.url,this.status,Map<String, dynamic> json}) {
    this.message = json["message"];
    this.details = json["details"];
    this.information_link = json["information_link"];
  }

  String toString() => "HttpErrorResult Error:\n  Status: $status\n  Message: $message";
}