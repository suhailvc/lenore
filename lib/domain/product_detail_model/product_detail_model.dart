import 'dart:convert';

class ProductDetailModel {
  bool? status;
  String? message;
  Data? data;
  List<RelatedProducts>? relatedProducts;

  ProductDetailModel(
      {this.status, this.message, this.data, this.relatedProducts});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    if (json['related_products'] != null) {
      relatedProducts = [];
      json['related_products'].forEach((v) {
        relatedProducts!.add(RelatedProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data?.toJson();
    if (this.relatedProducts != null) {
      data['related_products'] =
          this.relatedProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? namear;
  String? sku;
  int? stock;
  List<String>? images;
  int? price;
  Category? category;
  Category? subCategory;
  dynamic event; // Can be a Map or String
  dynamic collection; // Can be a Map or String
  int? makingPrice;
  String? longDescription;
  String? longDescriptionar;
  String? goldWeight;
  String? goldColour;
  String? type;
  String? diamondWeight;
  String? diamondColour;
  String? diamondClarity;
  String? goldPurity;
  bool? newArrival;
  bool? bestSeller;
  bool? status;
  List<CurrentGoldRate>? currentGoldRate;

  Data({
    this.id,
    this.name,
    this.namear,
    this.sku,
    this.stock,
    this.images,
    this.price,
    this.category,
    this.subCategory,
    this.event,
    this.collection,
    this.makingPrice,
    this.longDescription,
    this.longDescriptionar,
    this.goldWeight,
    this.goldColour,
    this.type,
    this.diamondWeight,
    this.diamondColour,
    this.diamondClarity,
    this.goldPurity,
    this.newArrival,
    this.bestSeller,
    this.status,
    this.currentGoldRate,
  });

  Data.fromJson(Map<String, dynamic> json) {
    // Parse id, stock, price, and makingPrice as int, whether they come as int or String
    id = json['id'] is String ? int.tryParse(json['id']) : json['id'];
    stock =
        json['stock'] is String ? int.tryParse(json['stock']) : json['stock'];
    price =
        json['price'] is String ? int.tryParse(json['price']) : json['price'];
    makingPrice = json['making_price'] is String
        ? int.tryParse(json['making_price'])
        : json['making_price'];

    name = json['name'];
    namear = json['namear'];
    sku = json['sku'];
    images = json['images']?.cast<String>();

    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    subCategory = json['sub_category'] != null
        ? Category.fromJson(json['sub_category'])
        : null;

    // Check if event and collection are Maps; if so, extract their 'name' fields as strings.
    event = json['event'] is Map ? json['event']['name'] : json['event'];
    collection = json['collection'] is Map
        ? json['collection']['name']
        : json['collection'];

    longDescription = json['long_description'];
    longDescriptionar = json['long_descriptionar'];
    goldWeight = json['gold_weight'];
    goldColour = json['gold_colour'];
    type = json['type'];
    diamondWeight = json['diamond_weight'];
    diamondColour = json['diamond_colour'];
    diamondClarity = json['diamond_clarity'];
    goldPurity = json['gold_purity'];
    newArrival = json['new_arrival'];
    bestSeller = json['best_seller'];
    status = json['status'];

    if (json['current_gold_rate'] != null) {
      currentGoldRate = [];
      json['current_gold_rate'].forEach((v) {
        currentGoldRate!.add(CurrentGoldRate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['namear'] = namear;
    data['sku'] = sku;
    data['stock'] = stock;
    data['images'] = images;
    data['price'] = price;

    data['category'] = category?.toJson();
    data['sub_category'] = subCategory?.toJson();

    data['event'] = event;
    data['collection'] = collection;
    data['making_price'] = makingPrice;
    data['long_description'] = longDescription;
    data['long_descriptionar'] = longDescriptionar;
    data['gold_weight'] = goldWeight;
    data['gold_colour'] = goldColour;
    data['type'] = type;
    data['diamond_weight'] = diamondWeight;
    data['diamond_colour'] = diamondColour;
    data['diamond_clarity'] = diamondClarity;
    data['gold_purity'] = goldPurity;
    data['new_arrival'] = newArrival;
    data['best_seller'] = bestSeller;
    data['status'] = status;

    if (currentGoldRate != null) {
      data['current_gold_rate'] =
          currentGoldRate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? name;
  String? namear;

  Category({this.name, this.namear});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    namear = json['namear'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['namear'] = namear;
    return data;
  }
}

class CurrentGoldRate {
  String? purity;
  int? price;

  CurrentGoldRate({this.purity, this.price});

  CurrentGoldRate.fromJson(Map<String, dynamic> json) {
    purity = json['purity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['purity'] = purity;
    data['price'] = price;
    return data;
  }
}

class RelatedProducts {
  int? id;
  String? name;
  String? namear;
  String? thumbImage;
  int? price;

  RelatedProducts(
      {this.id, this.name, this.namear, this.thumbImage, this.price});

  RelatedProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    namear = json['namear'];
    thumbImage = json['thumb_image'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['namear'] = namear;
    data['thumb_image'] = thumbImage;
    data['price'] = price;
    return data;
  }
}
