import 'dart:io';

import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:yaml/yaml.dart';
import 'dart:io';

class CrawlerInterceptor implements InterceptorContract {
  String userAgent;

  CrawlerInterceptor(this.userAgent);

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    data.headers[HttpHeaders.userAgentHeader] = userAgent;
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async =>
      data;
}
