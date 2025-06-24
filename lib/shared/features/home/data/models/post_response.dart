class PostsResponse {
  final int results;
  final List<Post> posts;

  PostsResponse({required this.results, required this.posts});

  factory PostsResponse.fromJson(Map<String, dynamic> json) {
    return PostsResponse(
      results: json['results'],
      posts: List<Post>.from(json['data'].map((item) => Post.fromJson(item))),
    );
  }

  Map<String, dynamic> toJson() {
    return {'results': results, 'data': posts.map((e) => e.toJson()).toList()};
  }
}

class Post {
  final String id;
  final String content;
  final int reactsCount;
  final int repostsCount;
  final List<Reaction> reacts;
  final User user;
  final List<String> images;
  final String slug;
  final RePost? repostedFrom;
  final int repostCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  Post({
    required this.id,
    required this.content,
    required this.user,
    required this.reactsCount,
    required this.images,
    required this.slug,
    required this.reacts,
    required this.repostedFrom,
    required this.repostCount,
    required this.createdAt,
    required this.repostsCount,
    required this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      reacts: (json['reacts'] as List<dynamic>).map((e) => Reaction.fromJson(e)).toList(),
      reactsCount: json['reactsCount'],
      repostsCount: json['repostsCount'],
      content: json['content'] ?? '',
      user: User.fromJson(json['user']),
      images: List<String>.from(json['images']),
      slug: json['slug'] ?? '',
      repostedFrom: json['repostedFrom'] == null ? null : RePost.fromJson(json['repostedFrom']),
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
    return User(id: json['_id'], name: json['name'], image: json['image'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'name': name};
  }
}

class Reaction {
  final String id;
  final User user;
  final String post;
  final String type;
  final DateTime createdAt;
  final int v;

  Reaction({
    required this.id,
    required this.user,
    required this.post,
    required this.type,
    required this.createdAt,
    required this.v,
  });

  factory Reaction.fromJson(Map<String, dynamic> json) {
    return Reaction(
      id: json['_id'],
      user: User.fromJson(json['user']),
      post: json['post'],
      type: json['type'],
      createdAt: DateTime.parse(json['createdAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user.toJson(),
      'post': post,
      'type': type,
      'createdAt': createdAt.toIso8601String(),
      '__v': v,
    };
  }
}

class RePost {
  final String id;
  final String content;
  final User user;
  final int repostCount;

  RePost({required this.id, required this.content, required this.user, required this.repostCount});

  factory RePost.fromJson(Map<String, dynamic> json) {
    return RePost(
      id: json['_id'] as String,
      content: json['content'] as String,
      user: User.fromJson(json['user']),
      repostCount: json['repostCount'] as int,
    );
  }
}
