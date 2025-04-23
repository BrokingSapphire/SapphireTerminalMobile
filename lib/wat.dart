// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class CustomTabBarExample extends StatelessWidget {
//   final List<String> tabNames;
//   final int selectedIndex;
//   final Function(int) onTabTapped;
//   final Function(int, String) onEditWatchlist;
//   final Function(String) onCreateWatchlist;
//   final Function(List<String>) onAddCategory;
//   final bool isDark;

//   const CustomTabBarExample({
//     super.key,
//     required this.tabNames,
//     required this.selectedIndex,
//     required this.onTabTapped,
//     required this.onEditWatchlist,
//     required this.onCreateWatchlist,
//     required this.onAddCategory,
//     required this.isDark,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final List<GlobalKey> tabKeys = List.generate(tabNames.length, (_) => GlobalKey());
//     double indicatorLeft = 0;
//     double indicatorWidth = 0;

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (selectedIndex < tabKeys.length) {
//         final keyContext = tabKeys[selectedIndex].currentContext;
//         if (keyContext != null) {
//           final box = keyContext.findRenderObject() as RenderBox?;
//           if (box != null) {
//             final position = box.localToGlobal(Offset.zero);
//             indicatorLeft = position.dx;
//             indicatorWidth = box.size.width;
//           }
//         }
//       }
//     });

//     return Container(
//       height: 50,
//       color: Colors.black,
//       child: Stack(
//         children: [
//           Positioned.fill(
//             child: Container(
//               alignment: Alignment.bottomCenter,
//               child: Container(height: 1, color: const Color(0xff2f2f2f)),
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             left: indicatorLeft,
//             child: Container(
//               height: 2,
//               width: indicatorWidth,
//               color: Colors.green,
//             ),
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: List.generate(tabNames.length, (index) {
//                       final isSelected = selectedIndex == index;
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 12),
//                         child: GestureDetector(
//                           key: tabKeys[index],
//                           onTap: () => onTabTapped(index),
//                           onLongPress: () => onEditWatchlist(index, tabNames[index]),
//                           child: Text(
//                             tabNames[index],
//                             style: TextStyle(
//                               color: isSelected ? Colors.green : Colors.white,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//                   ),
//                 ),
//               ),s
//               IconButton(
//                 onPressed: () {
//                   onCreateWatchlist("New Watchlist");
//                   onAddCategory(["Stocks", "Crypto"]);
//                 },
//                 icon: const Icon(Icons.add, color: Colors.white),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }