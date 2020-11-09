import 'dart:collection';
import 'package:intl/intl.dart';
import 'package:sortedmap/sortedmap.dart';
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';
import 'dart:convert';
import 'package:convert/convert.dart';
import '../../common/constants/env.dart';

class Authorization {
  static final EMPTY_BODY_SHA256 = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855";
  static final UNSIGNED_PAYLOAD = "UNSIGNED-PAYLOAD";
  static final X_OP_AUTHORIZATION_HEADER = "X-OP-Authorization";
  static final X_OP_DATE_HEADER = "X-OP-Date";
  static final X_OP_EXPIRES_HEADER = "X-OP-Expires";
  static final SCHEME = "OWS1";
  static final TERMINATOR = "ows1_request";
  DateFormat yyyyMMdd = DateFormat('yyyyMMdd');
  DateFormat yyyyMMddTHHmmssZ = DateFormat("yyyyMMdd'T'HHmmss'Z'");
  DateFormat yyyy_MM_ddTHH_mm_ssZ = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");

  String _httpMethod;
  String _uri;
  String _algorithm;
  String _credential;
  String _region;
  String _service;
  String _terminator;
  String _signedHeaderNames;
  String _signature;
  String _accessKeyId;
  String _secretAccessKey;
  int _expires;
  DateTime _timeStamp;

  SortedMap<String, String> _queryParameters;
  SortedMap<String, String> _signedHeaders;
  Map<String, String> _debugInfo;
  Uint8List _payload;

  Authorization.ExpectCurrentTime(String accessKeyId, String secretAccessKey, String region, String service, String httpMethod, String uri, Map queryParameters, Map signedHeaders, Uint8List payload): this.OWS1_HMAC_SHA256(accessKeyId, secretAccessKey, region, service, httpMethod, uri, queryParameters, signedHeaders, payload, DateTime.parse(signedHeaders["X-OP-Date"].replaceAll("[-:]", "")), int.parse(signedHeaders["X-OP-Expires"]));

  Authorization.OWS1_HMAC_SHA256(String accessKeyId, String secretAccessKey, String region, String service, String httpMethod, String uri, Map queryParameters, Map signedHeaders, Uint8List payload, DateTime dateTime, int expires) : this("OWS1-HMAC-SHA256", accessKeyId, secretAccessKey, region, service, "ows1_request", httpMethod, uri, queryParameters, signedHeaders, payload, dateTime, expires);

  Authorization(String algorithm, String accessKeyId, String secretAccessKey, String region, String service, String terminator, String httpMethod, String uri, Map queryParameters, Map signedHeaders, Uint8List payload, DateTime timeStamp, int expires){

    this._queryParameters = new SortedMap();
    this._signedHeaders = new SortedMap();
    this._debugInfo = new HashMap();
    this._algorithm = algorithm;
    this._accessKeyId = accessKeyId;
    this._secretAccessKey = secretAccessKey;
    this._timeStamp = timeStamp;
    this._region = region;
    this._service = service;
    this._terminator = terminator;
    this._credential = accessKeyId + "/" + yyyyMMdd.format(timeStamp.toUtc()) + "/" + region + "/" + service + "/" + terminator;
    this._httpMethod = httpMethod;
    this._uri = uri;
    if (queryParameters != null && queryParameters.length > 0) {
      this._queryParameters.addAll(queryParameters);
    }

    if (signedHeaders != null && signedHeaders.length > 0) {
      this._signedHeaders.addAll(signedHeaders);
    }

    this._payload = payload;
    this._expires = expires;
    this._sign();
  }

  String get httpMethod => this._httpMethod;
  String get algorithm => this._algorithm;
  String get uri => this._uri;
  String get credential => this._credential;
  String get region => this._region;
  String get service => this._service;
  String get terminator => this._terminator;
  String get signedHeaderNames => this._signedHeaderNames;
  String get signature => this._signature;
  String get accessKeyId => this._accessKeyId;
  String get secretAccessKey => this._secretAccessKey;
  int get expires => this._expires;
  DateTime get timeStamp => this._timeStamp;
  Map get queryParameters => this._queryParameters;
  Map<String, String> get signedHeaders => this._signedHeaders;
  Map<String, String> get debugInfo =>  this._debugInfo;

  bool isExpired() {
    return (DateTime.now().millisecondsSinceEpoch - this.timeStamp.millisecondsSinceEpoch) / 1000 > this.expires;
  }

  String toString() {
    return this.algorithm + " Credential=" + this.credential + ",SignedHeaders=" + this.signedHeaderNames + ",Signature=" + this.signature;
  }

  String toQueryString() {
    return "X-OP-Algorithm=${this.algorithm}&X-OP-Credential=${_uriEncode(this.credential, true)}&X-OP-Date=${yyyyMMddTHHmmssZ.format(this._timeStamp.toUtc())}&X-OP-Expires=${this.expires}&X-OP-SignedHeaders=${_uriEncode(this.signedHeaderNames, true)}&X-OP-Signature=${this.signature}";
  }

  String _uriEncode(String uri,bool encodeSlash) {
    if(encodeSlash) {
      return Uri.encodeComponent(uri);
    }
    return Uri.encodeFull(uri);
  }

  Uint8List _hmacSha256(String key, String data) {
    final secretKey = SecretKey(utf8.encode(key));
    final macAlgorithm = const Hmac(sha256);
    final sink = macAlgorithm.newSink(secretKey: secretKey);
    sink.add(utf8.encode(data));
    sink.close();
    final macBytes = sink.mac.bytes;
    return macBytes;
  }

  Uint8List _hmacSha256UsingListInt(Uint8List key, String data) {
    final secretKey = SecretKey(key);
    final macAlgorithm = const Hmac(sha256);
    final sink = macAlgorithm.newSink(secretKey: secretKey);
    sink.add(utf8.encode(data));
    sink.close();
    final macBytes = sink.mac.bytes;
    return macBytes;
  }

  Uint8List _sha256Hash(String data) {
    final sink = sha256.newSink();
    sink.add(utf8.encode(data));
    sink.close();
    final hash = sink.hash;
    return hash.bytes;
  }

  Uint8List _sha256HashUsingListInt(Uint8List data) {
    final sink = sha256.newSink();
    sink.add(data);
    sink.close();
    final hash = sink.hash;
    return hash.bytes;
  }


  String _hexData(Uint8List data) {
    return hex.encode(data);
  }

  void _sign() {
    //encode uri
    String canonicalUri = _uriEncode(this.uri, false);
    //encode queryString
    var canonicalQueryArray = <String>[];
    this.queryParameters.forEach((key, value) {
      var encodeParam = new StringBuffer()
        ..write(_uriEncode(key, true))
        ..write("=")
        ..write(_uriEncode(value, true));
      canonicalQueryArray.add(encodeParam.toString());
    });
    var canonicalQueryString = canonicalQueryArray.join("&");
    //encode headers
    var canonicalHeadersArray = <String>[];
    var buffArray = <String>[];
    this.signedHeaders.forEach((key, value) {
      var encodeParam = new StringBuffer()
        ..write(key.toLowerCase())
        ..write(":")
        ..write(value);
      canonicalHeadersArray.add(encodeParam.toString());
      buffArray.add(key.toLowerCase());
    });
    this._signedHeaderNames = buffArray.join(";");
    String hashedPayload = this._payload != null ? (this._payload.length > 0 ? _hexData(_sha256HashUsingListInt(this._payload)) : "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855") : "UNSIGNED-PAYLOAD";
    String canonicalRequest = this.httpMethod + "\n" + canonicalUri + "\n" + canonicalQueryString.toString() + "\n" + canonicalHeadersArray.join("\n") + "\n\n" + this.signedHeaderNames + "\n" + hashedPayload;
    String timeStamp = yyyyMMddTHHmmssZ.format(this.timeStamp.toUtc());
    String scope = yyyyMMdd.format(this.timeStamp.toUtc()) + "/" + this.region + "/" + this.service + "/" + this.terminator;
    String stringToSign = this.algorithm + "\n" + timeStamp + "\n" + scope + "\n" + _hexData(_sha256Hash(canonicalRequest));
    Uint8List dateKey = _hmacSha256("OWS1" + this.secretAccessKey, yyyyMMdd.format(this.timeStamp.toUtc()));
    Uint8List dateRegionKey = _hmacSha256UsingListInt(dateKey, this.region);
    Uint8List dateRegionServiceKey = _hmacSha256UsingListInt(dateRegionKey, this.service);
    Uint8List signingKey = _hmacSha256UsingListInt(dateRegionServiceKey, this.terminator);
    this._signature = _hexData(_hmacSha256UsingListInt(signingKey, stringToSign));
    this._debugInfo["canonicalRequest"] =  canonicalRequest;
    this._debugInfo["stringToSign"] = stringToSign;
    this._debugInfo["dateKey"] =  _hexData(dateKey);
    this._debugInfo["dateRegionKey"] = _hexData(dateRegionKey);
    this._debugInfo["dateRegionServiceKey"] = _hexData(dateRegionServiceKey);
    this._debugInfo["signingKey"] = _hexData(signingKey);
  }
}

void main() {
  var ONEPAY_PCS_SERVICE_PREFIX = environment["SERVICE_PREFIX"];
  var ONEPAY_PCS_SERVICE_NAME= environment["SERVICE_NAME"];
  var ONEPAY_PCS_SERVICE_REGION = environment["SERVICE_REGION"];
  var ONEPAY_PCS_SERVICE_CLIENT_ID = environment["SERVICE_CLIENT_ID"];
  var ONEPAY_PSP_SERVICE_CLIENT_KEY = environment["SERVICE_CLIENT_KEY"];
  var requestTimeOut = int.parse(environment["SERVICE_REQUEST_TIMEOUT"]);
  var requestDate = DateTime.now();
  final DateFormat yyyyMMddTHHmmssZ = DateFormat("yyyyMMdd'T'HHmmss'Z'");
  var requestMethod = "PUT";
  var requestURI = "/partners/HHHH1/users/HHH2/card_links/HHH3";
  var queryParamMap = {"card": "hello", "merchant_data": "world"};
  var signedHeaderMap = {"X-OP-Date": yyyyMMddTHHmmssZ.format(requestDate.toUtc()), "X-OP-Expires": requestTimeOut.toString()};
  var bodyMap = {};
  Uint8List payload = utf8.encode(jsonEncode(bodyMap));

  var serviceAuthorization = new Authorization.OWS1_HMAC_SHA256(
      ONEPAY_PCS_SERVICE_CLIENT_ID,
      ONEPAY_PSP_SERVICE_CLIENT_KEY,
      ONEPAY_PCS_SERVICE_REGION, ONEPAY_PCS_SERVICE_NAME, requestMethod,
      ONEPAY_PCS_SERVICE_PREFIX + requestURI, queryParamMap, signedHeaderMap,
      payload, requestDate, requestTimeOut);

  print("serviceAuthorization: " + serviceAuthorization.toString());
  print( "serviceAuthorization debug info: " + serviceAuthorization.debugInfo.toString());
  print(serviceAuthorization.toString());
}