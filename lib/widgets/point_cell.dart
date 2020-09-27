import 'package:flutter/material.dart';

class PointCell extends StatelessWidget {
  final String text;
  final String subText;
  final Image image;
  final VoidCallback onTap;
  const PointCell({Key key, this.text, this.subText, this.image, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(text),
                Text(subText)
              ],
            ),
            SizedBox(width: 30,),
            image
          ],
        ));
  }
}
