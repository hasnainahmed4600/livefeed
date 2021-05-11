part of '../api.dart';

class UpdateMarketplacePostPriceCommand {
  PostPriceDto price = null;

  UpdateMarketplacePostPriceCommand();

  @override
  String toString() {
    return 'UpdateMarketplacePostPriceCommand[price=$price, ]';
  }

  UpdateMarketplacePostPriceCommand.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    price = new PostPriceDto.fromJson(json['price']);
  }

  Map<String, dynamic> toJson() {
    return {'price': price};
  }

  static List<UpdateMarketplacePostPriceCommand> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<UpdateMarketplacePostPriceCommand>()
        : json
            .map((value) =>
                new UpdateMarketplacePostPriceCommand.fromJson(value))
            .toList();
  }

  static Map<String, UpdateMarketplacePostPriceCommand> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdateMarketplacePostPriceCommand>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new UpdateMarketplacePostPriceCommand.fromJson(value));
    }
    return map;
  }
}
