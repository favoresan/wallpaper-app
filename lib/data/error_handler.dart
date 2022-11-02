import '../presentation/resources/strings_manager.dart';
import 'network/failure.dart';
import 'package:dio/dio.dart';

//1
enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORIZED,
  NOT_FOUND,
  INTERNAL_SERVICE_ERROR,
  CONNECTION_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

//5
class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      //dio error its error from response from api
      failure = _handleError(error);
    } else {
      //default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }
  Failure _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return DataSource.CONNECTION_TIMEOUT.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();

      case DioErrorType.receiveTimeout:
        return DataSource.RECEIVE_TIMEOUT.getFailure();

      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case ResponseCode.BAD_REQUEST:
            return DataSource.BAD_REQUEST.getFailure();
          case ResponseCode.FORBIDDEN:
            return DataSource.FORBIDDEN.getFailure();
          case ResponseCode.UNAUTHORIZED:
            return DataSource.UNAUTHORIZED.getFailure();
          case ResponseCode.NOT_FOUND:
            return DataSource.NOT_FOUND.getFailure();
          case ResponseCode.INTERNAL_SERVICE_ERROR:
            return DataSource.INTERNAL_SERVICE_ERROR.getFailure();
          default:
            return DataSource.DEFAULT.getFailure();
        }
      case DioErrorType.cancel:
        return DataSource.CANCEL.getFailure();

      case DioErrorType.other:
        return DataSource.DEFAULT.getFailure();
    }
  }
}

//4
extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);

      case DataSource.UNAUTHORIZED:
        return Failure(ResponseCode.UNAUTHORIZED, ResponseMessage.UNAUTHORIZED);

      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);

      case DataSource.INTERNAL_SERVICE_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVICE_ERROR,
            ResponseMessage.INTERNAL_SERVICE_ERROR);

      case DataSource.CONNECTION_TIMEOUT:
        return Failure(ResponseCode.CONNECTION_TIMEOUT,
            ResponseMessage.CONNECTION_TIMEOUT);

      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);

      case DataSource.RECEIVE_TIMEOUT:
        return Failure(
            ResponseCode.RECEIVE_TIMEOUT, ResponseMessage.RECEIVE_TIMEOUT);

      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);

      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);

      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);

      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);

      default:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

//2
class ResponseCode {
  //API status codes
  static const int SUCCESS = 200; //success with data
  static const int NO_CONTENT = 201; //success with no content
  static const int BAD_REQUEST = 400; //failure, api rejected request
  static const int FORBIDDEN = 403; //failure, api rejected request
  static const int UNAUTHORIZED = 401; // failure, user is unauthorized
  static const int NOT_FOUND =
      404; //failure, api url is not correct & not found
  static const int INTERNAL_SERVICE_ERROR =
      500; // failure, crash happening at server side

  //local status codes
  static const int DEFAULT = -1;
  static const int CONNECTION_TIMEOUT = -2;
  static const int CANCEL = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_CONNECTION = -7;
}

//3
class ResponseMessage {
  //API status codes
  static const String SUCCESS = AppStrings.success; //success with data
  static const String NO_CONTENT =
      AppStrings.noContent; //success with no content
  static const String BAD_REQUEST =
      AppStrings.badRequestError; //failure, api rejected request
  static const String FORBIDDEN =
      AppStrings.forbiddenError; //failure, api rejected request
  static const String UNAUTHORIZED =
      AppStrings.unauthorizedError; // failure, user is unauthorized
  static const String NOT_FOUND =
      AppStrings.notFoundError; //failure, api url is not correct & not found
  static const String INTERNAL_SERVICE_ERROR = AppStrings
      .internalServiceError; // failure, crash happening at server side

  //local status codes
  static const String DEFAULT = AppStrings.defaultError;
  static const String CONNECTION_TIMEOUT = AppStrings.timeoutError;
  static const String CANCEL = AppStrings.defaultError;
  static const String RECEIVE_TIMEOUT = AppStrings.timeoutError;
  static const String SEND_TIMEOUT = AppStrings.timeoutError;
  static const String CACHE_ERROR = AppStrings.cacheError;
  static const String NO_INTERNET_CONNECTION = AppStrings.noInternetError;
}

// class ApiInternalStatus {
//   static const int SUCCESS = 0;
//   static const int FAILURE = 1;
// }
