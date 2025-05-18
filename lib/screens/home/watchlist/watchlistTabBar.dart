import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/utils/constWidgets.dart';

class WatchlistTabBar extends StatefulWidget {
  final List<String> tabNames;
  final int selectedIndex;
  final Function(int) onTabTapped;
  final Function(int index, String newName)? onEditWatchlist;
  final Function(String name)? onCreateWatchlist;
  final Function(List<String> categories)? onAddCategory;
  final Function(int index)? onDeleteWatchlist;
  final bool isDark;

  const WatchlistTabBar({
    super.key,
    required this.tabNames,
    required this.selectedIndex,
    required this.onTabTapped,
    this.onEditWatchlist,
    this.onCreateWatchlist,
    this.onAddCategory,
    this.onDeleteWatchlist,
    required this.isDark,
  });

  @override
  _WatchlistTabBarState createState() => _WatchlistTabBarState();
}

class _WatchlistTabBarState extends State<WatchlistTabBar> {
  late List<GlobalKey> tabKeys;
  double indicatorLeft = 0;
  double indicatorWidth = 0;

  @override
  void initState() {
    super.initState();
    _initTabKeys();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateIndicator());
  }

  @override
  void didUpdateWidget(WatchlistTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tabNames.length != widget.tabNames.length ||
        oldWidget.selectedIndex != widget.selectedIndex) {
      _initTabKeys();
      WidgetsBinding.instance.addPostFrameCallback((_) => _updateIndicator());
    }
  }

  void _initTabKeys() {
    tabKeys = List.generate(widget.tabNames.length, (_) => GlobalKey());
  }

  void _updateIndicator() {
    if (widget.selectedIndex >= tabKeys.length) return;

    final keyContext = tabKeys[widget.selectedIndex].currentContext;
    if (keyContext != null) {
      final box = keyContext.findRenderObject() as RenderBox?;
      if (box != null) {
        final position = box.localToGlobal(Offset.zero);
        setState(() {
          indicatorLeft = position.dx;
          indicatorWidth = box.size.width;
        });
      }
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? const Color(0xff121413) : Colors.white,
        title: Text(
          "Delete Watchlist",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        content: Text(
          "Are you sure you want to delete '${widget.tabNames[index]}'? This action cannot be undone.",
          style: TextStyle(
            fontSize: 14.sp,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              widget.onDeleteWatchlist?.call(index);
              Navigator.pop(context);
            },
            child: Text(
              "Delete",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditWatchlistModal(
      BuildContext context, int index, String currentName) {
    final controller = TextEditingController(text: currentName);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: widget.isDark ? const Color(0xff121413) : Colors.white,
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
                Text(
                  "Rename Watchlist",
                  style: TextStyle(
                    fontSize: 21.sp,
                    fontWeight: FontWeight.bold,
                    color: widget.isDark ? Colors.white : Colors.black,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, index);
                  },
                  icon: SvgPicture.asset(
                    "assets/svgs/delete.svg",
                    color: widget.isDark ? Colors.white : Colors.black,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: widget.isDark ? Colors.white : Colors.black,
                  ),
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
                  color: widget.isDark ? const Color(0xffEBEEF5) : Colors.black,
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: controller,
              maxLength: 10,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                hintText: "Enter Watchlist Name",
                labelStyle:
                    TextStyle(color: isDark ? Color(0xffC9CACC) : Colors.black),
                hintStyle: TextStyle(
                  color: isDark ? const Color(0xFFC9CACC) : Colors.black,
                  fontSize: 15.sp,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.r)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.r)),
                  borderSide: const BorderSide(color: Color(0XFF2F2F2F)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.r)),
                  borderSide: const BorderSide(color: Colors.green, width: 2.0),
                ),
                counter: ValueListenableBuilder(
                  valueListenable: controller,
                  builder: (context, value, child) {
                    return Text(
                      "${controller.text.length}/10",
                      style: TextStyle(
                        color: isDark ? Color(0xFFC9CACC) : Colors.black,
                        fontSize: 12.sp,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 16.h),
            constWidgets.greenButton("Save", onTap: () {
              if (controller.text.trim().isNotEmpty) {
                widget.onEditWatchlist?.call(index, controller.text.trim());
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: widget.isDark ? const Color(0xff121413) : Colors.white,
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
                  Text(
                    "Create New Watchlist",
                    style: TextStyle(
                      fontSize: 21.sp,
                      fontWeight: FontWeight.bold,
                      color: widget.isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: widget.isDark ? Colors.white : Colors.black,
                    ),
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
                    color:
                        widget.isDark ? const Color(0xffEBEEF5) : Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              TextField(
                controller: controller,
                maxLength: 10,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  hintText: "Enter Watchlist Name",
                  labelStyle: TextStyle(
                      color: isDark ? Color(0xffC9CACC) : Colors.black),
                  hintStyle: TextStyle(
                      color: isDark ? const Color(0xFFC9CACC) : Colors.black,
                      fontSize: 15.sp),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.r)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.r)),
                    borderSide: const BorderSide(color: Color(0XFF2F2F2F)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.r)),
                    borderSide:
                        const BorderSide(color: Colors.green, width: 2.0),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              constWidgets.greenButton("Create", onTap: () {
                if (controller.text.trim().isNotEmpty) {
                  widget.onCreateWatchlist?.call(controller.text.trim());
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xff121413) : Colors.white,
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
                  style: TextStyle(
                      fontSize: 21.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black),
                ),
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
                "Enter Category Name",
                style: TextStyle(
                  color: isDark ? const Color(0xffEBEEF5) : Colors.black,
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              maxLength: 50,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              controller: controller,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                hintText: "Enter Category Name",
                labelStyle:
                    TextStyle(color: isDark ? Color(0xffC9CACC) : Colors.black),
                hintStyle: TextStyle(
                    color: isDark ? const Color(0xFFC9CACC) : Colors.black,
                    fontSize: 15.sp),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.r)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.r)),
                  borderSide: const BorderSide(color: Color(0XFF2F2F2F)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.r)),
                  borderSide: const BorderSide(color: Colors.green, width: 2.0),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            constWidgets.greenButton("Add", onTap: () {
              if (controller.text.trim().isNotEmpty) {
                String input = controller.text.trim();
                String capitalized = input.toUpperCase();
                widget.onAddCategory?.call([capitalized]);
                Navigator.pop(context);
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
      backgroundColor: widget.isDark ? const Color(0xff121413) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            contentPadding: EdgeInsets.only(left: 16.w),
            minLeadingWidth: 16.w,
            leading: SvgPicture.asset(
              "assets/svgs/createWatchlist.svg",
              height: 20.h,
              width: 20.w,
              color: widget.isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              "Create Watchlist",
              style:
                  TextStyle(color: widget.isDark ? Colors.white : Colors.black),
            ),
            onTap: () {
              Navigator.pop(context);
              _showCreateWatchlistModal(context);
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 16.w),
            minLeadingWidth: 16.w,
            leading: SvgPicture.asset(
              "assets/svgs/addCategories.svg",
              height: 20.h,
              width: 20.w,
              color: widget.isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              "Add Category",
              style:
                  TextStyle(color: widget.isDark ? Colors.white : Colors.black),
            ),
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
      height: 50.h,
      color: widget.isDark ? Colors.black : Colors.white,
      child: Stack(
        children: [
          // Grey divider
          Positioned.fill(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 1,
                color: const Color(0xff2f2f2f),
              ),
            ),
          ),
          // Green indicator
          Positioned(
            bottom: 0,
            left: indicatorLeft,
            child: Container(
              height: 2,
              width: indicatorWidth,
              color: Colors.green,
            ),
          ),
          // Tabs and add button
          Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(widget.tabNames.length, (index) {
                      final isSelected = widget.selectedIndex == index;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: GestureDetector(
                          key: tabKeys[index],
                          onTap: () {
                            widget.onTabTapped(index);
                            _updateIndicator();
                          },
                          onLongPress: () => _showEditWatchlistModal(
                              context, index, widget.tabNames[index]),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: Text(
                                widget.tabNames[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  letterSpacing: 1,
                                  color: isSelected
                                      ? Colors.green
                                      : (widget.isDark
                                          ? Colors.white
                                          : Colors.black),
                                  fontSize: 14.sp,
                                ),
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
                icon: Icon(
                  Icons.add,
                  color: widget.isDark ? Colors.white : Colors.black,
                ),
                onPressed: () => _showOptionsBottomSheet(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
