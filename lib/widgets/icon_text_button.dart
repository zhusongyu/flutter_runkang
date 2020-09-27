import 'package:flutter/material.dart';
import 'package:flutter_runkang/shared/image_factory.dart';

class IconTextButton extends StatelessWidget {
  final String text;
  final Image image;
  final VoidCallback onTap;
  const IconTextButton({Key key, this.text, this.image, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          image,
          SizedBox(
            height: 5,
          ),
          Text(text)
        ],
      ),
    );
  }
}
