import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/utils/constWidgets.dart';

class Pledge extends StatefulWidget {
  const Pledge({super.key});

  @override
  State<Pledge> createState() => _PledgeState();
}

class _PledgeState extends State<Pledge> with SingleTickerProviderStateMixin {
  late TabController tabController;
  final options = ['Pledge', 'Unpledge', 'History'];
  List<String> stocks = [];
  bool checked = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: options.length, vsync: this);
    tabController.addListener(() {
      setState(() {}); // Rebuild UI when a tab is selected
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Pledge',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
          centerTitle: false,
        ),
        body: Column(
          children: [
            // Custom Tab Bar
            CustomTabBar(
              tabController: tabController,
              options: options,
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  // Pledge Tab
                  PledgeContent(),
                  // Unpledge Tab
                  UnpledgeContent(),
                  // History Tab
                  HistoryContent(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Tab Bar
class CustomTabBar extends StatefulWidget {
  final TabController tabController;
  final List<String> options;

  const CustomTabBar(
      {required this.tabController, required this.options, Key? key})
      : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(() {
      if (mounted) setState(() {}); // Updates UI when tab changes
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(widget.options.length, (index) {
              bool isSelected = widget.tabController.index == index;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.tabController.animateTo(index);
                  },
                  child: Column(
                    children: [
                      Text(
                        widget.options[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? Color(0xff1DB954)
                              : Color(0xffEBEEF5),
                        ),
                      ),
                      SizedBox(height: 5.h),
                    ],
                  ),
                ),
              );
            }),
          ),
          // Green underline effect divided equally
          LayoutBuilder(
            builder: (context, constraints) {
              double segmentWidth =
                  constraints.maxWidth / widget.options.length;
              return Stack(
                children: [
                  Container(
                    height: 2.h,
                    width: double.infinity,
                    color: Colors.transparent,
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    left: widget.tabController.index * segmentWidth,
                    child: Container(
                      height: 2.h,
                      width: segmentWidth,
                      color: Color(0xff1DB954),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// Pledge Content Widget
class PledgeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: constWidgets.searchField(
              context, 'Search.....', 'pledge', isDark),
        ),
        SizedBox(height: 10.h),
        Expanded(
          child: ListView(
            children:const [
              _PledgeListItem(
                checked: false,
                stockName: 'BAJAJ-AUTO',
                haircut: '11.41%',
                qty: '100',
                totalQty: '100',
                margin: '₹1,995.55',
                avatarUrl: null, // Replace with actual image if needed
              ),
              _PledgeListItem(
                checked: false,
                stockName: 'GMRAIRPORT',
                haircut: '11.41%',
                qty: '1397',
                totalQty: '1397',
                margin: '₹1,995.55',
                avatarUrl: null, // Replace with actual image if needed
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Unpledge Content Widget
class UnpledgeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Unpledge Content', style: TextStyle(color: Colors.white)));
  }
}

// History Content Widget
class HistoryContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('History Content', style: TextStyle(color: Colors.white)));
  }
}

class _PledgeListItem extends StatefulWidget {
  final bool checked;
  final String stockName;
  final String haircut;
  final String qty;
  final String totalQty;
  final String margin;
  final String? avatarUrl;

  const _PledgeListItem({
    required this.checked,
    required this.stockName,
    required this.haircut,
    required this.qty,
    required this.totalQty,
    required this.margin,
    this.avatarUrl,
    Key? key,
  }) : super(key: key);

  @override
  State<_PledgeListItem> createState() => _PledgeListItemState();
}

class _PledgeListItemState extends State<_PledgeListItem> {
  late bool checked;

  @override
  void initState() {
    super.initState();
    checked = widget.checked;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          checked = !checked; // Toggle the checkbox
        });
        print('Tapped on ${widget.stockName}');
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              children: [
                // Custom checkbox design instead of the default one
                CustomCheckbox(
                    size: 18.sp,
                    value: checked,
                    onChanged: (value) {
                      setState(() {
                        checked = value!;
                      });
                    }),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(widget.stockName,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.sp)),
                          SizedBox(width: 8),
                          if (widget.avatarUrl != null)
                            CircleAvatar(
                              radius: 14,
                              backgroundImage: NetworkImage(widget.avatarUrl!),
                            )
                          else
                            CircleAvatar(
                              radius: 14.r,
                              backgroundColor: Colors.grey.shade800,
                              child: Icon(Icons.person,
                                  color: Colors.white, size: 18.sp),
                            ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text('Haircut  ${widget.haircut}',
                          style: TextStyle(color: Colors.grey, fontSize: 13)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text('Qty : ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500)),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 7.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Color(0xff23262B),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text('${widget.qty} / ${widget.totalQty}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text('Margin ${widget.margin}',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp)),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
