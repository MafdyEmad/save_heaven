import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/screens/make_post_screen.dart';
import 'package:save_heaven/core/utils/extensions.dart';

class MakePostWidget extends StatelessWidget {
  final String name;
  final String image;
  const MakePostWidget({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Icon(Icons.person),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(top: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: context.textTheme.headlineMedium),
                    GestureDetector(
                      onTap: () {
                        context.push(MakePostScreen(name: name, image: image));
                      },
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          readOnly: true,
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: 'What\'s happening?',
                            hintStyle: context.textTheme.headlineSmall?.copyWith(color: AppPalette.hintColor),
                            border: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
