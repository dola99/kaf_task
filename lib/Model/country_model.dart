class Country {
  final int id;
  final String countryCode;
  final String name;
  final String capital;

  Country({
    required this.id,
    required this.countryCode,
    required this.name,
    required this.capital,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      countryCode: json['country_code'],
      name: json['name'],
      capital: json['capital'],
    );
  }

  static List<Country> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => Country.fromJson(json)).toList();
  }
}

class PaginationData {
  final int count;
  final int total;
  final int perPage;
  final int currentPage;
  final int totalPages;
  final Map<String, dynamic> links;

  PaginationData({
    required this.count,
    required this.total,
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
    required this.links,
  });

  factory PaginationData.fromJson(Map<String, dynamic> json) {
    return PaginationData(
      count: json['count'],
      total: json['total'],
      perPage: json['perPage'],
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      links: json['links'],
    );
  }
}

class CountryResponse {
  final int status;
  final bool success;
  final List<Country> data;
  final PaginationData pagination;

  CountryResponse({
    required this.status,
    required this.success,
    required this.data,
    required this.pagination,
  });

  factory CountryResponse.fromJson(Map<String, dynamic> json) {
    return CountryResponse(
      status: json['status'],
      success: json['success'],
      data: Country.listFromJson(json['data']),
      pagination: PaginationData.fromJson(json['pagination']),
    );
  }
}
