import 'package:flutter/material.dart';
import 'package:stellartrack/model/product_list_model.dart';
import '../model/user_error.dart';
import '../repo/api_status.dart';
import '../repo/api_service.dart';
import '../utils/const/api_collection.dart';

class ProductListViewModel with ChangeNotifier {

  bool _loading = false;
  List<ProductListModel> _productListModel = [];
  UserError? _userError;

  ProductListViewModel() {
    getProductList();
  }

  bool get loading => _loading;
  List<ProductListModel> get productListModel => _productListModel;
  UserError? get userError => _userError;

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setProductListModel(List<ProductListModel> productListModel) {
    _productListModel = productListModel;
    notifyListeners();
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  getProductList() async {
    setLoading(true);
    var response = await ApiService.apiCall(apiUrl: PRODUCT_LIST_URL,);
    if(response is Success) {
      Object data = productListModelFromJson(response.response as String);
      setProductListModel(data as List<ProductListModel>);
    } else if(response is Failure) {
      UserError userError = UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setLoading(false);
  }

}