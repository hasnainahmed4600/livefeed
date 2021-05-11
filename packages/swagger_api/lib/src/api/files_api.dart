part of '../api.dart';

class FilesApi {
  final ApiClient apiClient;

  FilesApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  /// Generate a signed url for DOWNLOADING a file
  ///
  ///
  Future<GetSignedUrlForFileReadQueryResponseData>
      createSignedUrlForFileReadCommand(
          String authorization, GetSignedUrlForFileReadQuery body) async {
    Object postBody = body;

    // verify required params are set
    if (authorization == null) {
      throw new ApiException(400, "Missing required param: authorization");
    }
    if (body == null) {
      throw new ApiException(400, "Missing required param: body");
    }

    // create path and map variables
    String path = "/file".replaceAll("{format}", "json");

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
              response.body, 'GetSignedUrlForFileReadQueryResponseData')
          as GetSignedUrlForFileReadQueryResponseData;
    } else {
      return null;
    }
  }

  /// Generate a signed url for UPLOADING a file
  ///
  ///
  Future<CreateSignedUrlForFileUploadCommandResponseData>
      createSignedUrlForFileUploadCommand(String authorization,
          CreateSignedUrlForFileUploadCommand body) async {
    Object postBody = body;

    // verify required params are set
    if (authorization == null) {
      throw new ApiException(400, "Missing required param: authorization");
    }
    if (body == null) {
      throw new ApiException(400, "Missing required param: body");
    }

    // create path and map variables
    String path = "/file".replaceAll("{format}", "json");

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
              response.body, 'CreateSignedUrlForFileUploadCommandResponseData')
          as CreateSignedUrlForFileUploadCommandResponseData;
    } else {
      return null;
    }
  }
}
