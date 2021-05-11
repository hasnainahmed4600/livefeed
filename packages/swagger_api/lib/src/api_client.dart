part of './api.dart';

class QueryParam {
  String name;
  String value;

  QueryParam(this.name, this.value);
}

class ApiClient {
  String basePath;
  var client = new IOClient();

  Map<String, String> _defaultHeaderMap = {};
  Map<String, Authentication> _authentications = {};

  final _RegList = new RegExp(r'^List<(.*)>$');
  final _RegMap = new RegExp(r'^Map<String,(.*)>$');

  ApiClient({this.basePath: "https://livefeed.com/api/"}) {
    // Setup authentications (key: authentication name, value: authentication).
    _authentications['OAuth2'] = new OAuth();
  }

  void addDefaultHeader(String key, String value) {
    _defaultHeaderMap[key] = value;
  }

  dynamic _deserialize(dynamic value, String targetType) {
    try {
      switch (targetType) {
        case 'String':
          return '$value';
        case 'int':
          return value is int ? value : int.parse('$value');
        case 'bool':
          return value is bool ? value : '$value'.toLowerCase() == 'true';
        case 'double':
          return value is double ? value : double.parse('$value');
        case 'AdPosterDto':
          return new AdPosterDto.fromJson(value);
        case 'AddAdvertisementCommand':
          return new AddAdvertisementCommand.fromJson(value);
        case 'AddAdvertisementCommandResponseData':
          return new AddAdvertisementCommandResponseData.fromJson(value);
        case 'AddFeedbackCommand':
          return new AddFeedbackCommand.fromJson(value);
        case 'AddMarketplacePostCommand':
          return new AddMarketplacePostCommand.fromJson(value);
        case 'AddMarketplacePostCommandResponseData':
          return new AddMarketplacePostCommandResponseData.fromJson(value);
        case 'AddPostCommand':
          return new AddPostCommand.fromJson(value);
        case 'AddPostCommandResponseData':
          return new AddPostCommandResponseData.fromJson(value);
        case 'AdvertisementDto':
          return new AdvertisementDto.fromJson(value);
        case 'ApiResponse':
          return new ApiResponse.fromJson(value);
        case 'BrowsePostsCommand':
          return new BrowsePostsCommand.fromJson(value);
        case 'CategoryDto':
          return new CategoryDto.fromJson(value);
        case 'CreateSignedUrlForFileUploadCommand':
          return new CreateSignedUrlForFileUploadCommand.fromJson(value);
        case 'CreateSignedUrlForFileUploadCommandResponseData':
          return new CreateSignedUrlForFileUploadCommandResponseData.fromJson(
              value);
        case 'EditPostCommand':
          return new EditPostCommand.fromJson(value);
        case 'EditPostCommandResponseData':
          return new EditPostCommandResponseData.fromJson(value);
        case 'EditUserProfileCommand':
          return new EditUserProfileCommand.fromJson(value);
        case 'EditUserProfileCommandResponseData':
          return new EditUserProfileCommandResponseData.fromJson(value);
        case 'FileDto':
          return new FileDto.fromJson(value);
        case 'GetAdvertisementsListQueryResponseData':
          return new GetAdvertisementsListQueryResponseData.fromJson(value);
        case 'GetCategoryListQueryResponseData':
          return new GetCategoryListQueryResponseData.fromJson(value);
        case 'GetLiveFeedPostsListQuery':
          return new GetLiveFeedPostsListQuery.fromJson(value);
        case 'GetLiveFeedPostsListQueryResponseData':
          return new GetLiveFeedPostsListQueryResponseData.fromJson(value);
        case 'GetLocationsListQueryResponseData':
          return new GetLocationsListQueryResponseData.fromJson(value);
        case 'GetMarketplacePostQueryResponseData':
          return new GetMarketplacePostQueryResponseData.fromJson(value);
        case 'GetMarketplacePostsListQuery':
          return new GetMarketplacePostsListQuery.fromJson(value);
        case 'GetMarketplacePostsListQueryResponseData':
          return new GetMarketplacePostsListQueryResponseData.fromJson(value);
        case 'GetPostQueryResponseData':
          return new GetPostQueryResponseData.fromJson(value);
        case 'GetPostsListQuery':
          return new GetPostsListQuery.fromJson(value);
        case 'GetPostsListQueryResponseData':
          return new GetPostsListQueryResponseData.fromJson(value);
        case 'GetPostsListQueryResponseDataData':
          return new GetPostsListQueryResponseDataData.fromJson(value);
        case 'GetSignedUrlForFileReadQuery':
          return new GetSignedUrlForFileReadQuery.fromJson(value);
        case 'GetSignedUrlForFileReadQueryResponseData':
          return new GetSignedUrlForFileReadQueryResponseData.fromJson(value);
        case 'GetUserProfilePostsQuery':
          return new GetUserProfilePostsQuery.fromJson(value);
        case 'GetUserProfilePostsQueryResponseData':
          return new GetUserProfilePostsQueryResponseData.fromJson(value);
        case 'GetUserProfileQueryResponseData':
          return new GetUserProfileQueryResponseData.fromJson(value);
        case 'LocationDto':
          return new LocationDto.fromJson(value);
        case 'LoginCommand':
          return new LoginCommand.fromJson(value);
        case 'LoginCommandResponseData':
          return new LoginCommandResponseData.fromJson(value);
        case 'MarketplacePostDto':
          return new MarketplacePostDto.fromJson(value);
        case 'MarketplacePostListItemDto':
          return new MarketplacePostListItemDto.fromJson(value);
        case 'PatchAdvertisementCommand':
          return new PatchAdvertisementCommand.fromJson(value);
        case 'PatchPostCommand':
          return new PatchPostCommand.fromJson(value);
        case 'PhoneDto':
          return new PhoneDto.fromJson(value);
        case 'PostContributionDto':
          return new PostContributionDto.fromJson(value);
        case 'PostDto':
          return new PostDto.fromJson(value);
        case 'PostListItemDto':
          return new PostListItemDto.fromJson(value);
        case 'PostNotificationDto':
          return new PostNotificationDto.fromJson(value);
        case 'PostPriceDto':
          return new PostPriceDto.fromJson(value);
        case 'RelatedPostDto':
          return new RelatedPostDto.fromJson(value);
        case 'ResendVerificationCodeCommand':
          return new ResendVerificationCodeCommand.fromJson(value);
        case 'SignupCommand':
          return new SignupCommand.fromJson(value);
        case 'SignupCommandResponseData':
          return new SignupCommandResponseData.fromJson(value);
        case 'SignupCommandResponseDataData':
          return new SignupCommandResponseDataData.fromJson(value);
        case 'UpdateMarketplacePostPriceCommand':
          return new UpdateMarketplacePostPriceCommand.fromJson(value);
        case 'UpdateMarketplacePostPriceCommandResponseData':
          return new UpdateMarketplacePostPriceCommandResponseData.fromJson(
              value);
        case 'UserProfileDto':
          return new UserProfileDto.fromJson(value);
        case 'UserProfileDtoInterests':
          return new UserProfileDtoInterests.fromJson(value);
        case 'UserProfileInterestDto':
          return new UserProfileInterestDto.fromJson(value);
        case 'UserProfilePostDto':
          return new UserProfilePostDto.fromJson(value);
        case 'VerifyCommand':
          return new VerifyCommand.fromJson(value);
        case 'VerifyCommandData':
          return new VerifyCommandData.fromJson(value);
        case 'VerifyCommandResponseData':
          return new VerifyCommandResponseData.fromJson(value);
        case 'VerifyCommandResponseDataData':
          return new VerifyCommandResponseDataData.fromJson(value);
        default:
          {
            Match match;
            if (value is List &&
                (match = _RegList.firstMatch(targetType)) != null) {
              var newTargetType = match[1];
              return value.map((v) => _deserialize(v, newTargetType)).toList();
            } else if (value is Map &&
                (match = _RegMap.firstMatch(targetType)) != null) {
              var newTargetType = match[1];
              return new Map.fromIterables(value.keys,
                  value.values.map((v) => _deserialize(v, newTargetType)));
            }
          }
      }
    } catch (e, stack) {
      throw new ApiException.withInner(
          500, 'Exception during deserialization.', e, stack);
    }
    throw new ApiException(
        500, 'Could not find a suitable class for deserialization');
  }

  dynamic deserialize(String jsonVal, String targetType) {
    // Remove all spaces.  Necessary for reg expressions as well.
    targetType = targetType.replaceAll(' ', '');

    if (targetType == 'String') return jsonVal;

    var decodedJson = json.decode(jsonVal);
    return _deserialize(decodedJson, targetType);
  }

  String serialize(Object obj) {
    String serialized = '';
    if (obj == null) {
      serialized = '';
    } else {
      serialized = json.encode(obj);
    }
    return serialized;
  }

  // We don't use a Map<String, String> for queryParams.
  // If collectionFormat is 'multi' a key might appear multiple times.
  Future<Response> invokeAPI(
      String path,
      String method,
      Iterable<QueryParam> queryParams,
      Object body,
      Map<String, String> headerParams,
      Map<String, String> formParams,
      String contentType,
      List<String> authNames) async {
    _updateParamsForAuth(authNames, queryParams, headerParams);

    var ps = queryParams
        .where((p) => p.value != null)
        .map((p) => '${p.name}=${Uri.encodeQueryComponent(p.value)}');
    String queryString = ps.isNotEmpty ? '?' + ps.join('&') : '';

    String url = basePath + path + queryString;

    headerParams.addAll(_defaultHeaderMap);
    headerParams['Content-Type'] = contentType;

    if (body is MultipartRequest) {
      var request = new MultipartRequest(method, Uri.parse(url));
      request.fields.addAll(body.fields);
      request.files.addAll(body.files);
      request.headers.addAll(body.headers);
      request.headers.addAll(headerParams);
      var response = await client.send(request);
      return Response.fromStream(response);
    } else {
      var msgBody = contentType == "application/x-www-form-urlencoded"
          ? formParams
          : serialize(body);
      switch (method) {
        case "POST":
          return client.post(url, headers: headerParams, body: msgBody);
        case "PUT":
          return client.put(url, headers: headerParams, body: msgBody);
        case "DELETE":
          return client.delete(url, headers: headerParams);
        case "PATCH":
          return client.patch(url, headers: headerParams, body: msgBody);
        default:
          return client.get(url, headers: headerParams);
      }
    }
  }

  /// Update query and header parameters based on authentication settings.
  /// @param authNames The authentications to apply
  void _updateParamsForAuth(List<String> authNames,
      List<QueryParam> queryParams, Map<String, String> headerParams) {
    authNames.forEach((authName) {
      Authentication auth = _authentications[authName];
      if (auth == null)
        throw new ArgumentError("Authentication undefined: " + authName);
      auth.applyToParams(queryParams, headerParams);
    });
  }

  void setAccessToken(String accessToken) {
    _authentications.forEach((key, auth) {
      if (auth is OAuth) {
        auth.setAccessToken(accessToken);
      }
    });
  }
}
