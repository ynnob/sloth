import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class CrawlerRetryPoliciy extends RetryPolicy {
  @override
  int maxRetryAttempts = 5;

  @override
  bool shouldAttemptRetryOnException(Exception reason) {
    print(reason);

    return false;
  }

  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    if (response.statusCode < 200 || response.statusCode > 299) {
      return true;
    }

    return false;
  }
}
