class ApiEndpoints {
  static const String _base = 'https://5357-197-53-84-46.ngrok-free.app/api/v1';
  static const String socketUrl = 'ws://192.168.1.121:8000';

  static const String imageProvider =
      'https://5357-197-53-84-46.ngrok-free.app';
  static const String posts = '$_base/posts';
  static const String getUser = '$_base/users/getMe';
  static const String updateUser = '$_base/users/updateMe';
  static const String children = '$_base/children';
  static String rePost(postId) => '$_base/posts/$postId/repost';
  static const String reactPost = '$_base/reactions';
  static const String notifications = '$_base/notifications';
  static const String readNotification = '$_base/notifications/read';
  static const String unReadNotificationsCount =
      '$_base/notifications/notifications-unread';
  static const String adoptionRequests = '$_base/adoption-requests';
  static const String donationItems = '$_base/donation-items';
  static const String donations = '$_base/donations';
  static const String signUp = '$_base/auth/signup';
  static const String login = '$_base/auth/login';
}
