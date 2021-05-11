part of '../api.dart';

class PostsApi {
  final ApiClient apiClient;

  PostsApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  /// Create a new marketplace post
  ///
  ///
  Future<AddMarketplacePostCommandResponseData> addMarketplacePostCommand(
      String authorization, AddMarketplacePostCommand body) async {
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

    var response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(
              response.body, 'AddMarketplacePostCommandResponseData')
          as AddMarketplacePostCommandResponseData;
    } else {
      return null;
    }
  }

  /// Create a new post
  ///
  ///
  Future<AddPostCommandResponseData> addPostCommand(
      String authorization, AddPostCommand body) async {
    Object postBody = body;

    // verify required params are set
    if (authorization == null) {
      throw new ApiException(400, "Missing required param: authorization");
    }
    if (body == null) {
      throw new ApiException(400, "Missing required param: body");
    }

    // create path and map variables
    String path = "/posts".replaceAll("{format}", "json");

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
      return apiClient.deserialize(response.body, 'AddPostCommandResponseData')
          as AddPostCommandResponseData;
    } else {
      return null;
    }
  }

  /// Register browsing event for a set of posts by the user
  ///
  ///
  Future<ApiResponse> browsePostsCommand(
      String authorization, BrowsePostsCommand body) async {
    Object postBody = body;

    // verify required params are set
    if (authorization == null) {
      throw new ApiException(400, "Missing required param: authorization");
    }
    if (body == null) {
      throw new ApiException(400, "Missing required param: body");
    }

    // create path and map variables
    String path = "/posts".replaceAll("{format}", "json");

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

  /// Delete an existing post
  ///
  ///
  Future<ApiResponse> deletePostCommand(
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
    String path = "/posts/{postId}"
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

    var response = await apiClient.invokeAPI(path, 'DELETE', queryParams,
        postBody, headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'ApiResponse') as ApiResponse;
    } else {
      return null;
    }
  }

  /// Edit an existing post
  ///
  ///
  Future<EditPostCommandResponseData> editPostCommand(
      String authorization, String postId, EditPostCommand body) async {
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
    String path = "/posts/{postId}"
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

    var response = await apiClient.invokeAPI(path, 'PUT', queryParams, postBody,
        headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'EditPostCommandResponseData')
          as EditPostCommandResponseData;
    } else {
      return null;
    }
  }

  /// Get details of given post
  ///
  ///
  Future<GetPostQueryResponseData> getPostQuery(
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
    String path = "/posts/{postId}"
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
      return apiClient.deserialize(response.body, 'GetPostQueryResponseData')
          as GetPostQueryResponseData;
    } else {
      return null;
    }
  }

  /// Get list of posts for the timeline screen
  ///
  ///
  Future<GetPostsListQueryResponseData> getPostsListQuery(
      String authorization, GetPostsListQuery body) async {
    Object postBody = body;

    // verify required params are set
    if (authorization == null) {
      throw new ApiException(400, "Missing required param: authorization");
    }
    if (body == null) {
      throw new ApiException(400, "Missing required param: body");
    }

    // create path and map variables
    String path = "/posts".replaceAll("{format}", "json");

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
              response.body, 'GetPostsListQueryResponseData')
          as GetPostsListQueryResponseData;
    } else {
      return null;
    }
  }

  /// [TO BE CONFIRMED] Move post to marketplace or update its seen status
  ///
  ///
  Future<ApiResponse> patchPostCommand(
      String authorization, String postId, PatchPostCommand body) async {
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
    String path = "/posts/{postId}"
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
      return apiClient.deserialize(response.body, 'ApiResponse') as ApiResponse;
    } else {
      return null;
    }
  }
}
