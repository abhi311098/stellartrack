import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stellartrack/model/product_detail_model.dart';
import 'package:stellartrack/model/product_list_model.dart';
import '../model/user_error.dart';
import '../repo/api_status.dart';
import '../repo/api_service.dart';
import '../utils/const/api_collection.dart';

class ProductDetailViewModel with ChangeNotifier {

  bool _loading = true;
  ProductDetailModel? _productDetailModel;
  UserError? _userError;

  bool get loading => _loading;
  ProductDetailModel? get productDetailModel => _productDetailModel;
  UserError? get userError => _userError;

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setProductDetailModel(ProductDetailModel productDetailModel) {
    _productDetailModel = productDetailModel;
    notifyListeners();
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  getProductDetail(int id) async {
    setLoading(true);
    var response = await ApiService.apiCall(apiUrl: "$PRODUCT_LIST_URL/$id",);
    if(response is Success) {
      Object data = productDetailModelFromJson(response.response as String);
      setProductDetailModel(data as ProductDetailModel);
    } else if(response is Failure) {
      UserError userError = UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setLoading(false);
  }

}