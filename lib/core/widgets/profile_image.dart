import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.image,
    required this.radius,
    this.onTap,
  });

  final ImageProvider<Object>? image;
  final double radius;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: radius,
            backgroundColor: Colors.grey[300],
            backgroundImage: image is String
                ? CachedNetworkImageProvider(image as String)
                : image,
          ),
          if (image is String)
            CachedNetworkImage(
              imageUrl: image as String,
              errorWidget: (context, url, error) => const Icon(Icons.error),
              imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: radius,
                backgroundImage: imageProvider,
              ),
            ),
        ],
      ),
    );
  }
}
