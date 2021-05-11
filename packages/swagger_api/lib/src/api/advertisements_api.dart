part of '../api.dart';

class AdvertisementsApi {
  final ApiClient apiClient;

  AdvertisementsApi([ApiClient apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  /// Create a new advertisement
  ///
  ///
  Future<AddAdvertisementCommandResponseData> addAdvertisementCommand(
      String authorization, AddAdvertisementCommand body) async {
    Object postBody = body;

    // verify required params are set
    if (authorization == null) {
      throw new ApiException(400, "Missing required param: authorization");
    }
    if (body == null) {
      throw new ApiException(400, "Missing required param: body");
    }

    // create path and map variables
    String path = "/advertisements".replaceAll("{format}", "json");

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

    var response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(
              response.body, 'AddAdvertisementCommandResponseData')
          as AddAdvertisementCommandResponseData;
    } else {
      return null;
    }
  }

  /// Get list of advertisements
  ///
  ///
  Future<GetAdvertisementsListQueryResponseData> getAdvertisementsListQuery(
      String authorization) async {
    Object postBody = null;

    // verify required params are set
    if (authorization == null) {
      throw new ApiException(400, "Missing required param: authorization");
    }

    // create path and map variables
    String path = "/advertisements".replaceAll("{format}", "json");

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
              response.body, 'GetAdvertisementsListQueryResponseData')
          as GetAdvertisementsListQueryResponseData;
    } else {
      return null;
    }
  }

  /// Activate/Deactivate or Delete an advertisement
  ///
  ///
  Future<ApiResponse> patchAdvertisementCommand(
      String authorization, String adId, PatchAdvertisementCommand body) async {
    Object postBody = body;

    // verify required params are set
    if (authorization == null) {
      throw new ApiException(400, "Missing required param: authorization");
    }
    if (adId == null) {
      throw new ApiException(400, "Missing required param: adId");
    }
    if (body == null) {
      throw new ApiException(400, "Missing required param: body");
    }

    // create path and map variables
    String path = "/advertisements/{adId}"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "adId" + "}", adId.toString());

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

    var response = await apiClient.invokeAPI(path, 'PATCH', queryParams,
        postBody, headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'ApiResponse') as ApiResponse;
    } else {
      return null;
    }
  }
}
