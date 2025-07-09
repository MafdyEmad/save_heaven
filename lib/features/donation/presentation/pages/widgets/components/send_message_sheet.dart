import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:save_heaven/core/utils/extensions.dart';

class SendMessageSheet extends StatelessWidget {
  final TextEditingController messageController;
  final String orphanageName;

  const SendMessageSheet({
    super.key,
    required this.messageController,
    required this.orphanageName,
  });

  Future<void> pickFile(BuildContext context) async {
    final result = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxWidth: null,
      maxHeight: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: width * 0.04,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Wrap(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Send Message",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.045,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => context.pop(),
              ),
            ],
          ),
          SizedBox(height: width * 0.02),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: width * 0.015,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F3F3),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/icons/bethany.png', height: width * 0.05),
                const SizedBox(width: 6),
                Text(
                  orphanageName,
                  style: TextStyle(
                    fontSize: width * 0.035,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.close, size: 16, color: Colors.grey),
              ],
            ),
          ),
          SizedBox(height: width * 0.05),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(width * 0.04),
            child: TextField(
              controller: messageController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText:
                    "Welcome...!\nHow You Want To Donate To Our Orphanage ?\nOffer Your Skills",
                hintStyle: TextStyle(fontSize: 13),
              ),
            ),
          ),
          SizedBox(height: width * 0.04),

          /// ✅ Attach File Row
          Row(
            children: [
              IconButton(
                onPressed: () => pickFile(context),
                icon: const Icon(Icons.attach_file, color: Colors.black54),
              ),
              Expanded(
                child: Text(
                  'fileName' ?? "Attach File",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              TextButton(
                onPressed: () => context.pop(),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  context.pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF20255B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05,
                    vertical: 10,
                  ),
                ),
                child: const Text("Send"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
