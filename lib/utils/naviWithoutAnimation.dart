import 'package:flutter/material.dart';

void naviWithoutAnimation(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}
