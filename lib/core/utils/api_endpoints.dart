class ApiEndpoints {
  static const String _base = 'https://89b4ac269353.ngrok-free.app/api/v1';
  static const String socketUrl = 'ws://89b4ac269353.ngrok-free.app';
  static const String imageProvider = 'https://89b4ac269353.ngrok-free.app';
  static const String posts = '$_base/posts';
  static String getChildren(String id) => '$_base/users/$id/children';
  static const String getUser = '$_base/users/getMe';
  static const String visitAccount = '$_base/users';
  static const String aiSearch = '$_base/ai_search';
  static const String getOrphanages = '$_base/users/orphanages';
  static String getAllKids(String id) => '$_base/users/$id/children';
  static const String updateUser = '$_base/users/updateMe';
  static const String adopt = '$_base/adoption-requests';
  static const String children = '$_base/children';
  static const String savePosts = '$_base/posts/saved-posts';
  static String rePost(postId) => '$_base/posts/$postId/repost';
  static const String reactPost = '$_base/reactions';
  static const String notifications = '$_base/notifications';
  static const String readNotification = '$_base/notifications/read';
  static const String unReadNotificationsCount =
      '$_base/notifications/notifications-unread';
  static const String adoptionRequests = '$_base/adoption-requests';
  static const String donationItems = '$_base/donation-items';
  static const String donationsMony = '$_base/donations';
  static const String signUp = '$_base/auth/signup';
  static const String login = '$_base/auth/login';
  static const String sendOTP = '$_base/auth/forgotPassword';
  static const String resetPassword = '$_base/auth/resetPassword';
}
