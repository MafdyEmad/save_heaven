class OrphanagesResponse {
  final bool success;
  final int results;
  final List<Orphanage> data;

  OrphanagesResponse({
    required this.success,
    required this.results,
    required this.data,
  });

  factory OrphanagesResponse.fromJson(Map<String, dynamic> json) {
    return OrphanagesResponse(
      success: json['success'] as bool,
      results: json['results'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => Orphanage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'results': results,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class Orphanage {
  final String id;
  final String name;
  final String address;
  final String? image;

  Orphanage({
    required this.id,
    required this.name,
    required this.address,
    this.image,
  });

  factory Orphanage.fromJson(Map<String, dynamic> json) {
    return Orphanage(
      id: json['_id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      image: json['image'] as String?, // Nullable
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'address': address,
      if (image != null) 'image': image,
    };
  }
}
