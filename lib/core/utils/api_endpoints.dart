class ApiEndpoints {
  static const String _host = '2';
  static const String _base = 'http://192.168.1.$_host:8000/api/v1';
  static const String imageProvider = 'http://192.168.1.$_host:8000';
  static const String posts = '$_base/posts';
  static String rePost(postId) => '$_base/posts/$postId/repost';
  static const String reactPost = '$_base/reactions';
  static const String notifications = '$_base/notifications';
  static const String adoptionRequests = '$_base/adoption-requests';
  static const String signUp = '$_base/auth/signup';
  static const String login = '$_base/auth/login';
}
