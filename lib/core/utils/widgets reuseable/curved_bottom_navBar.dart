// ===== CurvedBottomNavBar.dart =====
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/features/kids/presentation/cubit/navigation%20cubit/navigation_cubit.dart';
import 'package:save_heaven/features/kids/presentation/pages/widgets/component/curve_border_painter.dart';
import 'package:save_heaven/features/kids/presentation/pages/widgets/component/custom_curve_clipper.dart';

class CurvedBottomNavBar extends StatelessWidget {
  const CurvedBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<NavigationCubit>().state;

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      elevation: 0,
      color: Colors.transparent,
      child: Stack(
        children: [
          CustomPaint(
            painter: CurveBorderPainter(),
            child: ClipPath(
              clipper: CustomCurveClipper(),
              child: Container(height: 75, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildIcon(context, Icons.home, 0),
                _buildIcon(context, Icons.family_restroom, 1),
                const SizedBox(width: 40),
                _buildIcon(context, Icons.article_outlined, 2),
                _buildIcon(context, Icons.person, 3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(BuildContext context, IconData icon, int index) {
    final bool isSelected = context.watch<NavigationCubit>().state == index;
    return IconButton(
      icon: Icon(icon, size: 26, color: isSelected ? const Color(0xFF21245B) : Colors.grey),
      onPressed: () {
        context.read<NavigationCubit>().changeTab(index);
      },
    );
  }
}
