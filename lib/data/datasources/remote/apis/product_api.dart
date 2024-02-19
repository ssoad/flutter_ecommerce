// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:get/get.dart';

import '../../../../core/extension/extension.dart';
import '../../../../core/services/local_storage_service.dart';
import '../api_endpoint.dart';
import '../core/api_provider.dart';
import '../core/api_request.dart';

enum RequestType {
  GetProductList,
  GetProductDetails,
}

class ProductAPI implements IHTTPRequest {
  final RequestType type;
  String? productId;

  ProductAPI._({required this.type, this.productId});

  ProductAPI.getProductList() : this._(type: RequestType.GetProductList);

  ProductAPI.getProductDetails({required String productId})
      : this._(type: RequestType.GetProductDetails, productId: productId);

  @override
  String get endpoint => APIEndpoint.BASE_URL;

  @override
  String get path {
    switch (type) {
      case RequestType.GetProductList:
        return APIEndpoint.PRODUCT_LIST;
      case RequestType.GetProductDetails:
        return APIEndpoint.PRODUCT_DETAILS;
      default:
        return "";
    }
  }

  @override
  HTTPMethod get method {
    switch (type) {
      case RequestType.GetProductList:
      case RequestType.GetProductDetails:
        return HTTPMethod.get;
      default:
        return HTTPMethod.get;
    }
  }

  @override
  Map<String, String> get headers {
    switch (type) {
      case RequestType.GetProductList:
      case RequestType.GetProductDetails:
        return {HttpHeaders.contentTypeHeader: 'application/json'};
      default:
        return {HttpHeaders.contentTypeHeader: 'application/json'};
    }
  }

  @override
  Map<String, String> get query {
    switch (type) {
      case RequestType.GetProductList:
        return {};
      case RequestType.GetProductDetails:
        return {
          "id": productId ?? "",
        };
      default:
        return {};
    }
  }

  @override
  get body {
    switch (type) {
      case RequestType.GetProductList:
      case RequestType.GetProductDetails:
        return {};
      default:
        return {};
    }
  }

  @override
  Future request() {
    return HTTPProvider.instance.request(this);
  }

  @override
  String get url => endpoint + path;
}
