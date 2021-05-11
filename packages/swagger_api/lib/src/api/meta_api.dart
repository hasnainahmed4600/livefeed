part of '../api.dart';

class MetaApi {
  final ApiClient apiClient;

  MetaApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  /// Get a list of categories that can be selected in forms
  ///
  ///
  Future<GetCategoryListQueryResponseData> getCategoryListQuery(
      String authorization) async {
    Object postBody = null;

    // verify required params are set
    if (authorization == null) {
      throw new ApiException(400, "Missing required param: authorization");
    }

    // create path and map variables
    String path = "/categories".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    headerParams["Authorization"] = authorization;

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = ["OAuth2"];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'GET', queryParams, postBody,
        headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(
              response.body, 'GetCategoryListQueryResponseData')
          as GetCategoryListQueryResponseData;
    } else {
      return null;
    }
  }

  /// Get a list of locations that can be selected in forms
  ///
  ///
  Future<GetLocationsListQueryResponseData> getLocationsListQuery(
      String authorization) async {
    Object postBody = null;

    // verify required params are set
    if (authorization == null) {
      throw new ApiException(400, "Missing required param: authorization");
    }

    // create path and map variables
    String path = "/locations".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    headerParams["Authorization"] = authorization;

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = ["OAuth2"];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'GET', queryParams, postBody,
        headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(
              response.body, 'GetLocationsListQueryResponseData')
          as GetLocationsListQueryResponseData;
    } else {
      return null;
    }
  }
}
