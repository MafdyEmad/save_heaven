import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:save_heaven/features/chat/presentation/screens/chat_screen.dart';
import 'package:save_heaven/core/services/web_socket.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_text_field.dart';

class SearchScreen extends StatefulWidget {
  final String myId;
  const SearchScreen({super.key, required this.myId});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final search = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    search.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    search.dispose();
    super.dispose();
  }

  void _emitSearch(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final trimmed = query.trim();
      if (trimmed.isEmpty) return;

      WebSocketServices.emitEvent('Search', {
        'userId': widget.myId,
        'query': trimmed,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search', style: context.textTheme.titleLarge),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.horizontalPagePadding,
        ),
        child: Column(
          children: [
            CustomTextField(
              hint: 'Search...',
              controller: search,
              onChanged: _emitSearch,
            ),
            Expanded(
              child: search.text.trim().isEmpty
                  ? Center(
                      child: Text(
                        'Search results will appear here',
                        style: context.textTheme.headlineLarge,
                      ),
                    )
                  : StreamBuilder(
                      stream: WebSocketServices.listenEvent('searchResult'),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data == null) {
                          return _buildShimmerList();
                        }

                        final rawData = snapshot.data;

                        List<_User> users = [];
                        try {
                          if (rawData is List) {
                            users = rawData
                                .map(
                                  (e) => _User.fromJson(
                                    Map<String, dynamic>.from(e),
                                  ),
                                )
                                .toList();
                          } else if (rawData is Map &&
                              rawData['data'] is List) {
                            users = (rawData['data'] as List)
                                .map(
                                  (e) => _User.fromJson(
                                    Map<String, dynamic>.from(e),
                                  ),
                                )
                                .toList();
                          }
                        } catch (e) {
                          debugPrint('Parsing error: $e');
                        }

                        // ✅ FILTER OUT YOURSELF
                        users = users
                            .where((user) => user.id != widget.myId)
                            .toList();
                        if (users.isEmpty) {
                          return Center(
                            child: Text(
                              'No users found',
                              style: context.textTheme.headlineLarge,
                            ),
                          );
                        }

                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          itemCount: users.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemBuilder: (context, index) {
                            final user = users[index];
                            return InkWell(
                              onTap: () {
                                context.push(
                                  ChatScreen(
                                    myId: widget.myId,
                                    userId: user.id,
                                    name: user.name,
                                    image: user.image,
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 32.5,
                                      backgroundImage: NetworkImage(
                                        '${ApiEndpoints.imageProvider}${user.image}',
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        user.name,
                                        style: context.textTheme.titleLarge,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.separated(
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: double.infinity,
          height: 80,
          color: Colors.white,
        ),
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemCount: 10,
    );
  }
}

class _User {
  final String id;
  final String name;
  final String image;

  _User({required this.id, required this.name, required this.image});

  factory _User.fromJson(Map<String, dynamic> map) {
    return _User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
    );
  }
}
