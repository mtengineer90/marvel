import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

import 'types.dart';

class ReqAPI {
  static Future<http.Response> get({required String endPoint, Map<String, String> headers = const {}}) async {
    return await _requisitionHandling(
      endPoint: endPoint,
      typeRequest: ReqTypes.post,
    );
  }

  static _requisitionHandling({
    required String endPoint,
    ReqTypes typeRequest = ReqTypes.get,
  }) async {
    String ts = DateTime.now().millisecondsSinceEpoch.toString();
    String apiKey = '0547163e6a65fe82775368ab067db9d5';
    String hash = md5.convert(utf8.encode("${ts}51e29d353762799da90b194d971484f2bf4fc028$apiKey")).toString();
    var credentials = "?ts=$ts&apikey=$apiKey&hash=$hash";

    var url = "https://developer.marvel.com/v1/public/$endPoint" + credentials;

    Map<String, String> headersAdd = {'Content-Type': 'application/json', 'Accept': 'application/json'};

    var responseDefault = http.Response(
        jsonEncode([
          {"Response": "Hata!"}
        ]),
        404);

    try {
      responseDefault = await http.get(Uri.parse(url), headers: headersAdd);
    } on SocketException catch (e) {
      responseDefault = http.Response(
          jsonEncode([
            {"Response": "İnternet bağlantınızı kontrol ediniz!"}
          ]),
          408);
    } on FormatException catch (e) {
      responseDefault = http.Response(
          jsonEncode([
            {"Response": "Sunucu Hatası!"}
          ]),
          404);
    } on Exception catch (e) {
      responseDefault = http.Response(
          jsonEncode([
            {"Response": 'Hata: $e'}
          ]),
          500);
    }
    return responseDefault;
  }
}