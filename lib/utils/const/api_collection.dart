const String BASE_URL = "https://fakestoreapi.com/";
const String PRODUCT_LIST_URL= "${BASE_URL}products";

//API Error

const invalidResponse = 100;
const httpException = 101;
const noInternet = 102;
const invalidFormat = 103;
const timeout = 104;
const unknownError = 105;
const successCode = 200;

const String invalidResponseMsg = "Invalid Response";
const String httpExceptionMsg = "Http Exception";
const String noInternetMsg = "No Internet";
const String invalidFormatMsg = "Invalid Format";
const String timeoutMsg = "Timeout";
const String unknownErrorMsg = "Unknown Error";