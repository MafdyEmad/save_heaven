import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/extensions.dart';

class RequestDetailsScreen extends StatefulWidget {
  const RequestDetailsScreen({super.key});

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final imageUrl = '';
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPagePadding),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: context.width * .5,
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: imageUrl.isNotEmpty ? CachedNetworkImageProvider(imageUrl) : null,
                  child: imageUrl.isEmpty ? Icon(Icons.person, size: 40, color: Colors.grey) : null,
                ),
              ),
              SizedBox(height: 20),
              Text("Ali", style: context.textTheme.titleLarge?.copyWith(color: AppPalette.primaryColor)),
              SizedBox(height: 8),
              Text(
                "11-year-old ,male ,white stright-haired ,primary educated and muslim",
                textAlign: TextAlign.center,
                style: context.textTheme.headlineSmall?.copyWith(color: AppPalette.primaryColor),
              ),
              Divider(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Date',
                    style: context.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    DateFormat('MMMM dd, yyyy').format(DateTime.now()),
                    style: context.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Divider(height: 50),
              Text(
                "application information",
                style: context.textTheme.titleLarge?.copyWith(color: AppPalette.primaryColor),
              ),
              SizedBox(height: 20),
              _buildInformations('submitted name', ' zahraa saber'),
              Divider(),
              _buildInformations('Birth date', DateFormat('dd/mm/yyyy').format(DateTime.now())),
              Divider(),
              _buildInformations('martial status', 'married'),
              Divider(),
              _buildInformations('occupation', 'Engineer'),
              Divider(),
              _buildInformations('monthly income', '6000\$'),
              Divider(),
              _buildInformations('location', 'Thrive Early Learning Centre -the5th'),
              Divider(),
              _buildInformations('phone number', '01207902447'),
              Divider(),
              SizedBox(height: 20),
              Text(
                'why do you want to adopt?',
                style: context.textTheme.headlineLarge?.copyWith(color: Colors.black),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: Text(
                  'I want to make a difference in a child’s life. Adoption is not just about giving them a home, but also hope and opportunities.',
                  style: context.textTheme.bodyLarge,
                ),
              ),

              SizedBox(height: 20),
              SizedBox(height: 20),
              SizedBox(
                width: context.width * .6,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Accept Request',
                    style: context.textTheme.headlineLarge?.copyWith(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: context.width * .6,
                height: 50,
                child: OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
                  ),
                  onPressed: () {},
                  child: Text("Reject Request", style: context.textTheme.headlineLarge),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInformations(String infoHeader, String info) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(infoHeader, style: context.textTheme.headlineLarge?.copyWith(color: Colors.grey)),
        ),
        Expanded(
          child: Align(
            // alignment: AlignmentDirectional.topEnd,
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              info,
              style: context.textTheme.headlineLarge?.copyWith(color: AppPalette.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
