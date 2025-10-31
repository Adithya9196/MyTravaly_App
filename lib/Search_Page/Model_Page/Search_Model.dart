import 'dart:convert';

SearchModel searchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  final bool status;
  final String message;
  final int responseCode;
  final SearchModelData? data;

  SearchModel({
    required this.status,
    required this.message,
    required this.responseCode,
    this.data,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      responseCode: json["responseCode"] ?? 0,
      data: (json["data"] != null && json["data"] is Map<String, dynamic>)
          ? SearchModelData.fromJson(json["data"])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "responseCode": responseCode,
        "data": data?.toJson(),
      };
}

class SearchModelData {
  final List<ArrayOfHotelList> arrayOfHotelList;
  final List<String> arrayOfExcludedHotels;
  final List<String> arrayOfExcludedSearchType;

  SearchModelData({
    required this.arrayOfHotelList,
    required this.arrayOfExcludedHotels,
    required this.arrayOfExcludedSearchType,
  });

  factory SearchModelData.fromJson(Map<String, dynamic> json) {
    return SearchModelData(
      arrayOfHotelList: (json["arrayOfHotelList"] as List?)?.map((e) {
            if (e is Map<String, dynamic>) {
              return ArrayOfHotelList.fromJson(e);
            } else {
              return ArrayOfHotelList.empty();
            }
          }).toList() ??
          [],
      arrayOfExcludedHotels:
          List<String>.from(json["arrayOfExcludedHotels"] ?? <String>[]),
      arrayOfExcludedSearchType:
          List<String>.from(json["arrayOfExcludedSearchType"] ?? <String>[]),
    );
  }

  Map<String, dynamic> toJson() => {
        "arrayOfHotelList": arrayOfHotelList.map((e) => e.toJson()).toList(),
        "arrayOfExcludedHotels": arrayOfExcludedHotels,
        "arrayOfExcludedSearchType": arrayOfExcludedSearchType,
      };
}

class ArrayOfHotelList {
  final String propertyCode;
  final String propertyName;
  final PropertyImage propertyImage;
  final String propertytype;
  final int propertyStar;
  final PropertyPoliciesAndAmmenities propertyPoliciesAndAmmenities;
  final PropertyAddress propertyAddress;
  final String propertyUrl;
  final String roomName;
  final int numberOfAdults;
  final Price markedPrice;
  final Price propertyMaxPrice;
  final Price propertyMinPrice;
  final List<AvailableDeal> availableDeals;
  final SubscriptionStatus subscriptionStatus;
  final int propertyView;
  final bool isFavorite;
  final SimplPriceList simplPriceList;
  final GoogleReview googleReview;

  ArrayOfHotelList({
    required this.propertyCode,
    required this.propertyName,
    required this.propertyImage,
    required this.propertytype,
    required this.propertyStar,
    required this.propertyPoliciesAndAmmenities,
    required this.propertyAddress,
    required this.propertyUrl,
    required this.roomName,
    required this.numberOfAdults,
    required this.markedPrice,
    required this.propertyMaxPrice,
    required this.propertyMinPrice,
    required this.availableDeals,
    required this.subscriptionStatus,
    required this.propertyView,
    required this.isFavorite,
    required this.simplPriceList,
    required this.googleReview,
  });

  factory ArrayOfHotelList.empty() => ArrayOfHotelList(
        propertyCode: "",
        propertyName: "",
        propertyImage: PropertyImage.empty(),
        propertytype: "",
        propertyStar: 0,
        propertyPoliciesAndAmmenities: PropertyPoliciesAndAmmenities.empty(),
        propertyAddress: PropertyAddress.empty(),
        propertyUrl: "",
        roomName: "",
        numberOfAdults: 0,
        markedPrice: Price.empty(),
        propertyMaxPrice: Price.empty(),
        propertyMinPrice: Price.empty(),
        availableDeals: [],
        subscriptionStatus: SubscriptionStatus.empty(),
        propertyView: 0,
        isFavorite: false,
        simplPriceList: SimplPriceList.empty(),
        googleReview: GoogleReview.empty(),
      );

  factory ArrayOfHotelList.fromJson(Map<String, dynamic> json) {
    return ArrayOfHotelList(
      propertyCode: json["propertyCode"] ?? "",
      propertyName: json["propertyName"] ?? "",
      propertyImage: json["propertyImage"] is Map<String, dynamic>
          ? PropertyImage.fromJson(json["propertyImage"])
          : PropertyImage.empty(),
      propertytype: json["propertytype"] ?? "",
      propertyStar: (json["propertyStar"] ?? 0) is int
          ? (json["propertyStar"] ?? 0)
          : int.tryParse("${json["propertyStar"] ?? 0}") ?? 0,
      propertyPoliciesAndAmmenities:
          json["propertyPoliciesAndAmmenities"] is Map<String, dynamic>
              ? PropertyPoliciesAndAmmenities.fromJson(
                  json["propertyPoliciesAndAmmenities"])
              : PropertyPoliciesAndAmmenities.empty(),
      propertyAddress: json["propertyAddress"] is Map<String, dynamic>
          ? PropertyAddress.fromJson(json["propertyAddress"])
          : PropertyAddress.empty(),
      propertyUrl: json["propertyUrl"] ?? "",
      roomName: json["roomName"] ?? "",
      numberOfAdults: (json["numberOfAdults"] ?? 0) is int
          ? (json["numberOfAdults"] ?? 0)
          : int.tryParse("${json["numberOfAdults"] ?? 0}") ?? 0,
      markedPrice: Price.fromJson(json["markedPrice"] ?? {}),
      propertyMaxPrice: Price.fromJson(json["propertyMaxPrice"] ?? {}),
      propertyMinPrice: Price.fromJson(json["propertyMinPrice"] ?? {}),
      availableDeals: (json["availableDeals"] as List?)
              ?.map((e) => e is Map<String, dynamic>
                  ? AvailableDeal.fromJson(e)
                  : AvailableDeal.empty())
              .toList() ??
          [],
      subscriptionStatus: json["subscriptionStatus"] is Map<String, dynamic>
          ? SubscriptionStatus.fromJson(json["subscriptionStatus"])
          : SubscriptionStatus.empty(),
      propertyView: (json["propertyView"] ?? 0) is int
          ? (json["propertyView"] ?? 0)
          : int.tryParse("${json["propertyView"] ?? 0}") ?? 0,
      isFavorite: json["isFavorite"] ?? false,
      simplPriceList: json["simplPriceList"] is Map<String, dynamic>
          ? SimplPriceList.fromJson(json["simplPriceList"])
          : SimplPriceList.empty(),
      googleReview: json["googleReview"] is Map<String, dynamic>
          ? GoogleReview.fromJson(json["googleReview"])
          : GoogleReview.empty(),
    );
  }

  Map<String, dynamic> toJson() => {
        "propertyCode": propertyCode,
        "propertyName": propertyName,
        "propertyImage": propertyImage.toJson(),
        "propertytype": propertytype,
        "propertyStar": propertyStar,
        "propertyPoliciesAndAmmenities": propertyPoliciesAndAmmenities.toJson(),
        "propertyAddress": propertyAddress.toJson(),
        "propertyUrl": propertyUrl,
        "roomName": roomName,
        "numberOfAdults": numberOfAdults,
        "markedPrice": markedPrice.toJson(),
        "propertyMaxPrice": propertyMaxPrice.toJson(),
        "propertyMinPrice": propertyMinPrice.toJson(),
        "availableDeals": availableDeals.map((e) => e.toJson()).toList(),
        "subscriptionStatus": subscriptionStatus.toJson(),
        "propertyView": propertyView,
        "isFavorite": isFavorite,
        "simplPriceList": simplPriceList.toJson(),
        "googleReview": googleReview.toJson(),
      };
}

class AvailableDeal {
  final String headerName;
  final String websiteUrl;
  final String dealType;
  final Price price;

  AvailableDeal({
    required this.headerName,
    required this.websiteUrl,
    required this.dealType,
    required this.price,
  });

  factory AvailableDeal.empty() => AvailableDeal(
        headerName: "",
        websiteUrl: "",
        dealType: "",
        price: Price.empty(),
      );

  factory AvailableDeal.fromJson(Map<String, dynamic> json) => AvailableDeal(
        headerName: json["headerName"] ?? "",
        websiteUrl: json["websiteUrl"] ?? "",
        dealType: json["dealType"] ?? "",
        price: Price.fromJson(json["price"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "headerName": headerName,
        "websiteUrl": websiteUrl,
        "dealType": dealType,
        "price": price.toJson(),
      };
}

class Price {
  final double amount;
  final String displayAmount;
  final String currencyAmount;
  final String currencySymbol;

  Price({
    required this.amount,
    required this.displayAmount,
    required this.currencyAmount,
    required this.currencySymbol,
  });

  factory Price.empty() => Price(
        amount: 0.0,
        displayAmount: "",
        currencyAmount: "",
        currencySymbol: "",
      );

  factory Price.fromJson(Map<String, dynamic> json) {
    double amount = 0.0;
    if (json["amount"] != null) {
      if (json["amount"] is num) {
        amount = (json["amount"] as num).toDouble();
      } else {
        amount = double.tryParse("${json["amount"]}") ?? 0.0;
      }
    }

    return Price(
      amount: amount,
      displayAmount: json["displayAmount"]?.toString() ?? "",
      currencyAmount: json["currencyAmount"]?.toString() ?? "",
      currencySymbol: json["currencySymbol"]?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "displayAmount": displayAmount,
        "currencyAmount": currencyAmount,
        "currencySymbol": currencySymbol,
      };
}

class GoogleReview {
  final bool reviewPresent;
  final GoogleReviewData? data;

  GoogleReview({required this.reviewPresent, this.data});

  factory GoogleReview.empty() =>
      GoogleReview(reviewPresent: false, data: null);

  factory GoogleReview.fromJson(Map<String, dynamic> json) => GoogleReview(
        reviewPresent: json["reviewPresent"] ?? false,
        data: json["data"] is Map<String, dynamic>
            ? GoogleReviewData.fromJson(json["data"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "reviewPresent": reviewPresent,
        "data": data?.toJson(),
      };
}

class GoogleReviewData {
  final double overallRating;
  final int totalUserRating;
  final int withoutDecimal;

  GoogleReviewData({
    required this.overallRating,
    required this.totalUserRating,
    required this.withoutDecimal,
  });

  factory GoogleReviewData.fromJson(Map<String, dynamic> json) =>
      GoogleReviewData(
        overallRating: (json["overallRating"] ?? 0).toDouble(),
        totalUserRating: json["totalUserRating"] ?? 0,
        withoutDecimal: json["withoutDecimal"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "overallRating": overallRating,
        "totalUserRating": totalUserRating,
        "withoutDecimal": withoutDecimal,
      };
}

class PropertyAddress {
  final String street;
  final String city;
  final String state;
  final String country;
  final String zipcode;
  final String mapAddress;
  final double latitude;
  final double longitude;

  PropertyAddress({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.zipcode,
    required this.mapAddress,
    required this.latitude,
    required this.longitude,
  });

  factory PropertyAddress.empty() => PropertyAddress(
        street: "",
        city: "",
        state: "",
        country: "",
        zipcode: "",
        mapAddress: "",
        latitude: 0.0,
        longitude: 0.0,
      );

  factory PropertyAddress.fromJson(Map<String, dynamic> json) =>
      PropertyAddress(
        street: json["street"] ?? "",
        city: json["city"] ?? "",
        state: json["state"] ?? "",
        country: json["country"] ?? "",
        zipcode: json["zipcode"] ?? "",
        mapAddress: json["mapAddress"] ?? "",
        latitude: (json["latitude"] ?? 0).toDouble(),
        longitude: (json["longitude"] ?? 0).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "street": street,
        "city": city,
        "state": state,
        "country": country,
        "zipcode": zipcode,
        "mapAddress": mapAddress,
        "latitude": latitude,
        "longitude": longitude,
      };
}

class PropertyImage {
  final String fullUrl;
  final String location;
  final String imageName;

  PropertyImage({
    required this.fullUrl,
    required this.location,
    required this.imageName,
  });

  factory PropertyImage.empty() =>
      PropertyImage(fullUrl: "", location: "", imageName: "");

  factory PropertyImage.fromJson(Map<String, dynamic> json) => PropertyImage(
        fullUrl: json["fullUrl"] ?? "",
        location: json["location"] ?? "",
        imageName: json["imageName"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "fullUrl": fullUrl,
        "location": location,
        "imageName": imageName,
      };
}

class PropertyPoliciesAndAmmenities {
  final bool present;
  final PropertyPoliciesAndAmmenitiesData? data;

  PropertyPoliciesAndAmmenities({required this.present, this.data});

  factory PropertyPoliciesAndAmmenities.empty() =>
      PropertyPoliciesAndAmmenities(present: false, data: null);

  factory PropertyPoliciesAndAmmenities.fromJson(Map<String, dynamic> json) =>
      PropertyPoliciesAndAmmenities(
        present: json["present"] ?? false,
        data: json["data"] is Map<String, dynamic>
            ? PropertyPoliciesAndAmmenitiesData.fromJson(json["data"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "present": present,
        "data": data?.toJson(),
      };
}

class PropertyPoliciesAndAmmenitiesData {
  final String cancelPolicy;
  final String refundPolicy;
  final String childPolicy;
  final String damagePolicy;
  final String propertyRestriction;
  final bool petsAllowed;
  final bool coupleFriendly;
  final bool suitableForChildren;
  final bool bachularsAllowed;
  final bool freeWifi;
  final bool freeCancellation;
  final bool payAtHotel;
  final bool payNow;
  final DateTime? lastUpdatedOn;

  PropertyPoliciesAndAmmenitiesData({
    required this.cancelPolicy,
    required this.refundPolicy,
    required this.childPolicy,
    required this.damagePolicy,
    required this.propertyRestriction,
    required this.petsAllowed,
    required this.coupleFriendly,
    required this.suitableForChildren,
    required this.bachularsAllowed,
    required this.freeWifi,
    required this.freeCancellation,
    required this.payAtHotel,
    required this.payNow,
    this.lastUpdatedOn,
  });

  factory PropertyPoliciesAndAmmenitiesData.fromJson(
          Map<String, dynamic> json) =>
      PropertyPoliciesAndAmmenitiesData(
        cancelPolicy: json["cancelPolicy"] ?? "",
        refundPolicy: json["refundPolicy"] ?? "",
        childPolicy: json["childPolicy"] ?? "",
        damagePolicy: json["damagePolicy"] ?? "",
        propertyRestriction: json["propertyRestriction"] ?? "",
        petsAllowed: json["petsAllowed"] ?? false,
        coupleFriendly: json["coupleFriendly"] ?? false,
        suitableForChildren: json["suitableForChildren"] ?? false,
        bachularsAllowed: json["bachularsAllowed"] ?? false,
        freeWifi: json["freeWifi"] ?? false,
        freeCancellation: json["freeCancellation"] ?? false,
        payAtHotel: json["payAtHotel"] ?? false,
        payNow: json["payNow"] ?? false,
        lastUpdatedOn: (json["lastUpdatedOn"] != null)
            ? DateTime.tryParse(json["lastUpdatedOn"].toString())
            : null,
      );

  Map<String, dynamic> toJson() => {
        "cancelPolicy": cancelPolicy,
        "refundPolicy": refundPolicy,
        "childPolicy": childPolicy,
        "damagePolicy": damagePolicy,
        "propertyRestriction": propertyRestriction,
        "petsAllowed": petsAllowed,
        "coupleFriendly": coupleFriendly,
        "suitableForChildren": suitableForChildren,
        "bachularsAllowed": bachularsAllowed,
        "freeWifi": freeWifi,
        "freeCancellation": freeCancellation,
        "payAtHotel": payAtHotel,
        "payNow": payNow,
        "lastUpdatedOn": lastUpdatedOn?.toIso8601String(),
      };
}

class SimplPriceList {
  final Price simplPrice;
  final int originalPrice;

  SimplPriceList({required this.simplPrice, required this.originalPrice});

  factory SimplPriceList.empty() =>
      SimplPriceList(simplPrice: Price.empty(), originalPrice: 0);

  factory SimplPriceList.fromJson(Map<String, dynamic> json) => SimplPriceList(
        simplPrice: Price.fromJson(json["simplPrice"] ?? {}),
        originalPrice: json["originalPrice"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "simplPrice": simplPrice.toJson(),
        "originalPrice": originalPrice,
      };
}

class SubscriptionStatus {
  final bool status;

  SubscriptionStatus({required this.status});

  factory SubscriptionStatus.empty() => SubscriptionStatus(status: false);

  factory SubscriptionStatus.fromJson(Map<String, dynamic> json) =>
      SubscriptionStatus(status: json["status"] ?? false);

  Map<String, dynamic> toJson() => {"status": status};
}
