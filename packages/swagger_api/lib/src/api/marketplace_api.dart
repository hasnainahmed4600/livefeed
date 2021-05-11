part of '../api.dart';

class MarketplaceApi {
  final ApiClient apiClient;

  MarketplaceApi([ApiClient apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  /// Get details of a given marketplace post
  ///
  ///
  Future<GetMarketplacePostQueryResponseData> getMarketplacePostCommand(
      String authorization, String postId) async {
    Object postBody = null;

    // verify required params are set
    if (authorization == null) {
      throw new ApiException(400, "Missing required param: authorization");
    }
    if (postId == null) {
      throw new ApiException(400, "Missing required param: postId");
    }

    // create path and map variables
    String path = "/marketplace/posts/{postId}"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "postId" + "}", postId.toString());

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
              response.body, 'GetMarketplacePostQueryResponseData')
          as GetMarketplacePostQueryResponseData;
    } else {
      return null;
    }
  }

  /// Get list of posts for the Marketplace screen
  ///
  ///
  Future<GetMarketplacePostsListQueryResponseData> getMarketplacePostsListQuery(
      String authorization, GetMarketplacePostsListQuery body) async {
    Object postBody = body;

    // verify required params are set
    if (authorization == null) {
      throw new ApiException(400, "Missing required param: authorization");
    }
    if (body == null) {
      throw new ApiException(400, "Missing required param: body");
    }

    // create path and map variables
    String path = "/marketplace/posts".replaceAll("{format}", "json");

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
              response.body, 'GetMarketplacePostsListQueryResponseData')
          as GetMarketplacePostsListQueryResponseData;
    } else {
      return null;
    }
  }

  /// Set new price for a marketplace post
  ///
  ///
  Future<UpdateMarketplacePostPriceCommandResponseData>
      updateMarketplacePostPriceCommand(String authorization, String postId,
          UpdateMarketplacePostPriceCommand body) async {
    Object postBody = body;

    // verify required params are set
    if (authorization == null) {
      throw new ApiException(400, "Missing required param: authorization");
    }
    if (postId == null) {
      throw new ApiException(400, "Missing required param: postId");
    }
    if (body == null) {
      throw new ApiException(400, "Missing required param: body");
    }

    // create path and map variables
    String path = "/marketplace/posts/{postId}"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "postId" + "}", postId.toString());

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
      return apiClient.deserialize(
              response.body, 'UpdateMarketplacePostPriceCommandResponseData')
          as UpdateMarketplacePostPriceCommandResponseData;
    } else {
      return null;
    }
  }
}
