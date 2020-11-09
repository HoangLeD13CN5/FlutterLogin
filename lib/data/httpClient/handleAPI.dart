import 'dart:convert';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'authorization.dart';
import '../../common/constants/env.dart';
import 'httpErrorException.dart';

enum HttpMethodType { GET, POST, PUT, DELETE, PATCH }
class HandleAPI {
    String requestURI;
    String requestMethod = "GET";
    Map<String, String> queryParamMap = {};
    Map reqBody = {};

    HandleAPI(this.requestURI,HttpMethodType methodType,[this.queryParamMap,this.reqBody]) {
        this.requestMethod = EnumToString.parse(methodType);
    }

    String _uriEncode(String uri,bool encodeSlash) {
        if(encodeSlash) {
            return Uri.encodeComponent(uri);
        }
        return Uri.encodeFull(uri);
    }

    String _processURL(String requestURI, Map<String,String> queryParameters) {
        var uri = new StringBuffer(environment["BASE_URL"] + requestURI);
        if (!requestURI.contains("?") && queryParameters != null && queryParameters.isNotEmpty) {
            var canonicalQueryArray = <String>[];
            queryParameters.forEach((key, value) {
                var encodeParam = new StringBuffer()
                    ..write(_uriEncode(key, true))
                    ..write("=")
                    ..write(_uriEncode(value, true));
                canonicalQueryArray.add(encodeParam.toString());
            });
            uri.write("?${canonicalQueryArray.join("&")}");
        }
        return uri.toString();
    }

    Map<String,String> _createRequestHeader(String requestURI, String requestMethod, Map<String, String> queryParamMap, Map reqBody) {
        var ONEPAY_PCS_SERVICE_PREFIX = environment["SERVICE_PREFIX"];
        var ONEPAY_PCS_SERVICE_NAME= environment["SERVICE_NAME"];
        var ONEPAY_PCS_SERVICE_REGION = environment["SERVICE_REGION"];
        var ONEPAY_PCS_SERVICE_CLIENT_ID = environment["SERVICE_CLIENT_ID"];
        var ONEPAY_PSP_SERVICE_CLIENT_KEY = environment["SERVICE_CLIENT_KEY"];
        var requestTimeOut = int.parse(environment["SERVICE_REQUEST_TIMEOUT"]);
        var requestDate = DateTime.now();
        final DateFormat yyyyMMddTHHmmssZ = DateFormat("yyyyMMdd'T'HHmmss'Z'");
        var signedHeaderMap = {"X-OP-Date": yyyyMMddTHHmmssZ.format(requestDate.toUtc()), "X-OP-Expires": requestTimeOut.toString()};
        Uint8List payload = new Uint8List(0);
        if(reqBody.length > 0) {
            payload = utf8.encode(jsonEncode(reqBody));
        }
        var serviceAuthorization = new Authorization.OWS1_HMAC_SHA256(
            ONEPAY_PCS_SERVICE_CLIENT_ID,
            ONEPAY_PSP_SERVICE_CLIENT_KEY,
            ONEPAY_PCS_SERVICE_REGION, ONEPAY_PCS_SERVICE_NAME, requestMethod,
            ONEPAY_PCS_SERVICE_PREFIX + requestURI, queryParamMap, signedHeaderMap,
            payload, requestDate, requestTimeOut);

        print("serviceAuthorization: " + serviceAuthorization.toString());
        print( "serviceAuthorization debug info: " + serviceAuthorization.debugInfo.toString());
        print(serviceAuthorization.toString());
        return {
            "Content-Length":"${payload.length}",
            "Content-Type":"application/json",
            "Accept":"application/json",
            "Accept-Language":"vi/en",
            "X-OP-Expires":requestTimeOut.toString(),
            "X-OP-Date":yyyyMMddTHHmmssZ.format(requestDate.toUtc()),
            "X-OP-Authorization":serviceAuthorization.toString()
        };
    }

    Future<Map<String, dynamic>> processRequest() async {
        try{
            final response = await _createRequest();
            final responseJson = json.decode(response.body);
            if (response.statusCode >= 200 && response.statusCode <= 299) {
                if(responseJson != null) {
                    return responseJson;
                }
                return {};
            }else {
                if(responseJson != null) {
                    throw HttpErrorResult.fromJson(url: response.request.url.toString(), status: response.statusCode, json: responseJson);
                }
                throw HttpErrorResult(message: "Server Not Found", url: response.request.url.toString(), status: 404);
            }
        }catch (error) {
            throw error;
        }
    }

    Future<http.Response> _createRequest() async {
        switch(requestMethod.toUpperCase()) {
            case "GET":
                return await http.get(
                    _processURL(requestURI, queryParamMap),
                    headers: _createRequestHeader(requestURI, requestMethod, queryParamMap, reqBody)
                );
            case "PUT":
                return await http.put(
                    _processURL(requestURI, queryParamMap),
                    headers: _createRequestHeader(requestURI, requestMethod, queryParamMap, reqBody),
                    body: utf8.encode(jsonEncode(reqBody))
                );
            case "POST":
                return await http.post(
                    _processURL(requestURI, queryParamMap),
                    headers: _createRequestHeader(requestURI, requestMethod, queryParamMap, reqBody),
                    body: utf8.encode(jsonEncode(reqBody))
                );
            case "PATCH":
                return await http.patch(
                    _processURL(requestURI, queryParamMap),
                    headers: _createRequestHeader(requestURI, requestMethod, queryParamMap, reqBody),
                    body: utf8.encode(jsonEncode(reqBody))
                );
            case "DELETE":
                return await http.delete(
                    _processURL(requestURI, queryParamMap),
                    headers: _createRequestHeader(requestURI, requestMethod, queryParamMap, reqBody),
                );
            default:
                throw HttpMethodError(requestMethod.toUpperCase());
        }
    }
}

main() {
    var requestMethod = HttpMethodType.DELETE;
    String requestURI = "/partners/" + "H1220000989";
    var body = {"bank_account": "abc", "amount": "500000000", "type" : "cashout"};
    var queryParamMap = <String,String>{};
    switch(requestMethod) {
        case HttpMethodType.POST:
            requestURI = "/partners/" + "H1220000989";
            body = {"bank_account": "abc", "amount": "500000000", "type" : "cashout"};
            queryParamMap = <String,String>{};
            new HandleAPI(requestURI,requestMethod,queryParamMap,body).processRequest()
                .then((value) => print(value.toString()), onError: (error) => print((error as HttpErrorResult).toString()));
            break;
        case HttpMethodType.DELETE:
            requestURI = "/partners/H1220000989/invoices/INV-EC4E35CCC93340AF90580235CB85FA89";
            body = {};
            queryParamMap = <String,String>{};
            new HandleAPI(requestURI,requestMethod,queryParamMap,body).processRequest()
                .then((value) => print(value.toString()), onError: (error) => {
                if(error is HttpErrorResult) {
                    print((error as HttpErrorResult).toString())
                }else {
                    print(error.toString())
                }
            });
            break;
        case HttpMethodType.GET:
            requestURI = "/partners/H1220000989/users/USR-F6977AC093074062AFE4B7B92CEA3BBE/funds";
            body = {};
            queryParamMap = <String,String>{"page":"0", "page_size":"10"};
            new HandleAPI(requestURI,requestMethod,queryParamMap,body).processRequest()
                .then((value) => print(value.toString()), onError: (error) =>{
                if(error is HttpErrorResult) {
                    print((error as HttpErrorResult).toString())
                }else {
                    print(error.toString())
                }
            });
            break;
        default:
            break;
    }
}