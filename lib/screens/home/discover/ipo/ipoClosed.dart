import 'package:flutter/material.dart';

class upcomingIpo extends StatefulWidget {
  const upcomingIpo({Key? key}) : super(key: key);

  @override
  State<upcomingIpo> createState() => _upcomingIpoState();
}

class _upcomingIpoState extends State<upcomingIpo>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: isDark ? Colors.black : Colors.white,
      child: Center(
        child: Text(
          'No upcoming IPOs',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
