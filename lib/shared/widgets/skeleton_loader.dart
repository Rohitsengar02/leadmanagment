import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoader {
  static Widget rectangular({
    double width = double.infinity,
    double height = 20,
    BorderRadius? borderRadius,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
      ),
    );
  }

  static Widget circular({double size = 40}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  static Widget leadCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Row(
          children: [
            circular(size: 50),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  rectangular(width: 150, height: 16),
                  const SizedBox(height: 8),
                  rectangular(width: 100, height: 12),
                ],
              ),
            ),
            rectangular(
              width: 40,
              height: 24,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
      ),
    );
  }
}
