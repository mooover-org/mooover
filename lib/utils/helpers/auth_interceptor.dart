import 'package:http_interceptor/http_interceptor.dart';
import 'package:mooover/utils/services/user_session_services.dart';

class AuthInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    data.headers["Authorization"] =
        "Bearer ${UserSessionServices().accessToken}";
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async =>
      data;
}
