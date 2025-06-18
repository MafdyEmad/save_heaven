class PostsResponse {
  final int results;
  final PaginationResult paginationResult;
  final List<Post> posts;

  PostsResponse({required this.results, required this.paginationResult, required this.posts});

  factory PostsResponse.fromJson(Map<String, dynamic> json) {
    return PostsResponse(
      results: json['results'],
      paginationResult: PaginationResult.fromJson(json['paginationResult']),
      posts: List<Post>.from(json['data'].map((item) => Post.fromJson(item))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results,
      'paginationResult': paginationResult.toJson(),
      'data': posts.map((e) => e.toJson()).toList(),
    };
  }
}

class PaginationResult {
  final int currentPage;
  final int limit;
  final int numberOfPages;

  PaginationResult({required this.currentPage, required this.limit, required this.numberOfPages});

  factory PaginationResult.fromJson(Map<String, dynamic> json) {
    return PaginationResult(
      currentPage: json['currentPage'],
      limit: json['limit'],
      numberOfPages: json['numberOfPages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'currentPage': currentPage, 'limit': limit, 'numberOfPages': numberOfPages};
  }
}

class Post {
  final String id;
  final String content;
  final User user;
  final List<String> images;
  final String slug;
  final dynamic repostedFrom;
  final int repostCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  Post({
    required this.id,
    required this.content,
    required this.user,
    required this.images,
    required this.slug,
    required this.repostedFrom,
    required this.repostCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      content: json['content'],
      user: User.fromJson(json['user']),
      images: List<String>.from(json['images']),
      slug: json['slug'] ?? '',
      repostedFrom: json['repostedFrom'],
      repostCount: json['repostCount'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'content': content,
      'user': user.toJson(),
      'images': images,
      'slug': slug,
      'repostedFrom': repostedFrom,
      'repostCount': repostCount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class User {
  final String id;
  final String name;
  final String image;

  User({required this.id, required this.name, required this.image});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['_id'], name: json['name'], image: json['image']);
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'name': name};
  }
}
