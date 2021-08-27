import 'package:http_interceptor/http_interceptor.dart';

///logging interceptor for printing the calls log to console
class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData? data}) async {
    // print(data.toString());
    print("BEGIN REQUEST");
    print(
        'REQUEST: ${data?.method}\nPATH: ${data?.baseUrl}\nPARAMS: ${data?.params}\nHEADERS: ${data?.headers}\nBODY: ${data?.body}');
    print("END REQUEST");

    return data!;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData? data}) async {
    print(data.toString());
    print("BEGIN RESPONSE");
    print(
        'RESPONSE: ${data?.method}\nPATH: ${data?.url}\nSTATUS CODE: ${data?.statusCode}\nHEADERS: ${data?.headers}\nBODY: ${data?.body}\nREQUEST: ${data?.request}');
    print("END RESPONSE");
    return data!;
  }
}

class HeadersInterceptors implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      data.headers["Content-Type"] = "application/json";
      data.headers["Accept"] = "application/json";
    } catch (e) {
      print(e);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async =>
      data;
}
