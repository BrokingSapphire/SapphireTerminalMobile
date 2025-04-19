import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/utils/constWidgets.dart';

class WatchlistTabBar extends StatelessWidget {
  final List<String> tabNames;
  final int selectedIndex;
  final Function(int) onTabTapped;
  final Function(int index, String newName)? onEditWatchlist;
  final Function(String name)? onCreateWatchlist;
  final Function(List<String> categories)? onAddCategory;
  final bool isDark;

  const WatchlistTabBar({
    super.key,
    required this.tabNames,
    required this.selectedIndex,
    required this.onTabTapped,
    this.onEditWatchlist,
    this.onCreateWatchlist,
    this.onAddCategory,
    required this.isDark,
  });

  void _showEditWatchlistModal(
      BuildContext context, int index, String currentName) {
    final controller = TextEditingController(text: currentName);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xff121413) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          bottom: MediaQuery.of(context).viewInsets.bottom + 15.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Rename Watchlist",
                    style: TextStyle(
                        fontSize: 21.sp,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black)),
                Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      "assets/svgs/delete.svg",
                      color: Colors.white,
                    )),
                IconButton(
                  icon: Icon(Icons.close,
                      color: isDark ? Colors.white : Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Enter New Name",
                style: TextStyle(
                    color: isDark ? const Color(0xffEBEEF5) : Colors.black,
                    fontSize: 14.sp),
              ),
            ),
            SizedBox(height: 12.h),
          constWidgets.textField("", controller,
                isDark: isDark),
            SizedBox(height: 16.h),
            constWidgets.greenButton("Save", onTap: () {
              if (controller.text.trim().isNotEmpty) {
                onEditWatchlist?.call(index, controller.text.trim());
                Navigator.pop(context);
              }
            }),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }

  void _showCreateWatchlistModal(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xff121413) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            bottom: MediaQuery.of(context).viewInsets.bottom + 15.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Create New Watchlist",
                      style: TextStyle(
                          fontSize: 21.sp,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black)),
                  IconButton(
                    icon: Icon(Icons.close,
                        color: isDark ? Colors.white : Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Enter Watchlist Name",
                  style: TextStyle(
                      color: isDark ? Color(0xffEBEEF5) : Colors.black,
                      fontSize: 14.sp),
                ),
              ),
              SizedBox(height: 12.h),
            constWidgets.textField("", controller,
                  isDark: isDark),
              SizedBox(height: 16.h),
              constWidgets.greenButton("Create", onTap: () {
                if (controller.text.trim().isNotEmpty) {
                  onCreateWatchlist?.call(controller.text.trim());
                  Navigator.pop(context);
                }
              }),
              SizedBox(height: 15.h),
            ],
          ),
        );
      },
    );
  }

  void _showAddCategoryModal(BuildContext context) {
    final controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xff121413),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          bottom: MediaQuery.of(context).viewInsets.bottom + 15.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Add Category",
                  style:
                  TextStyle(fontSize: 21.sp, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Enter Category Name",
                style: TextStyle(
                  color: const Color(0xffEBEEF5),
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            constWidgets.textField("Category Name", controller, isDark: true),
            SizedBox(height: 8.h),
            constWidgets.greenButton("Add", onTap: () {
              if (controller.text.trim().isNotEmpty) {
                String input = controller.text.trim();
                String capitalized =
                input.toUpperCase(); // Convert to uppercase
                onAddCategory
                    ?.call([capitalized]); // Call callback with single category
                Navigator.pop(context); // Close the modal
              }
            }),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }

  void _showOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xff121413) : Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.playlist_add,
                color: isDark ? Colors.white : Colors.black),
            title: Text("Create Watchlist",
                style: TextStyle(color: isDark ? Colors.white : Colors.black)),
            onTap: () {
              Navigator.pop(context);
              _showCreateWatchlistModal(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.category,
                color: isDark ? Colors.white : Colors.black),
            title: Text("Add Category",
                style: TextStyle(color: isDark ? Colors.white : Colors.black)),
            onTap: () {
              Navigator.pop(context);
              _showAddCategoryModal(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDark ? Colors.black : Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(tabNames.length, (index) {
                      final isSelected = index == selectedIndex;
                      return GestureDetector(
                        onTap: () => onTabTapped(index),
                        onLongPress: () => _showEditWatchlistModal(
                            context, index, tabNames[index]),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: isSelected
                                    ? const Color(0xff1DB954)
                                    : Colors.transparent,
                                // color: isSelected ? (isDark ? Colo : const Color(0xff1DB954)) : (isDark ? Colors.transparent : Colors.transparent),
                                width: 2,
                              ),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              tabNames[index],
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.green
                                    : (isDark ? Colors.white : Colors.black),
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add,
                    color: isDark ? Colors.white : Colors.black),
                onPressed: () => _showOptionsBottomSheet(context),
              ),
            ],
          ),
          // Add a thin divider
          // Divider(
          //   height: 1.h, // Thin height
          //   thickness: 0.5, // Thin thickness
          //   color: const Color(0xff2F2F2F), // Matching the dark theme
          // ),
        ],
      ),
    );
  }
}
