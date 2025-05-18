// File: segmentSelection.dart
// Description: Investment segment selection screen in the Sapphire Trading application.
// This screen is part of the KYC flow and allows users to select which market segments they want to trade in.

import 'dart:convert'; // For JSON encoding/decoding
import 'dart:io'; // For File operations
import 'package:file_picker/file_picker.dart'; // For picking files
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // For secure storage
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/screens/auth/signUp/tradingAccountDetails/familyDetails.dart'; // Next screen in registration flow
import 'package:sapphire/main.dart'; // App-wide navigation utilities
import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI components

/// SegmentSelectionScreen - Screen for selecting market segments for trading
/// Allows users to choose which financial markets they want to access (equities, F&O, etc.)
/// as part of the trading account setup process
class SegmentSelectionScreen extends StatefulWidget {
  const SegmentSelectionScreen({super.key});

  @override
  State<SegmentSelectionScreen> createState() => _SegmentSelectionScreenState();
}

/// State class for the SegmentSelectionScreen widget
/// Manages segment selection state and navigation
class _SegmentSelectionScreenState extends State<SegmentSelectionScreen> {
  // Set to track which segments the user has selected
  Set<String> selectedSegments = {};
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  String? selectedDocument; // Tracks selected document in bottom sheet
  File? _selectedFile; // Selected file for income proof
  String? _selectedFileName; // Name of the selected file

  /// Pick a file using file_picker
  Future<void> _pickFile(
      BuildContext context, StateSetter setModalState) async {
    try {
      // Initialize FilePicker
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );

      if (result != null && result.files.isNotEmpty) {
        final path = result.files.single.path;
        final name = result.files.single.name;

        if (path != null) {
          setModalState(() {
            _selectedFile = File(path);
            _selectedFileName = name;
          });
        }
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking file: $e')),
      );
    }
  }

  // Mapping between UI display names and API parameter values
  final Map<String, String> segmentApiMap = {
    "Cash/Mutual Funds": "Cash",
    "F&O": "F&O",
    "Debt": "Debt",
    "Currency": "Currency",
    "Commodity Derivatives": "Commodity",
  };

  @override
  void initState() {
    super.initState();
    // Default selection - Cash/Mutual Funds is pre-selected for all users
    selectedSegments.add("Cash/Mutual Funds");
  }

  /// Toggles selection state of a segment
  /// Prevents deselection of "Cash/Mutual Funds"
  void _toggleSegment(String segment) {
    setState(() {
      if (segment == "Cash/Mutual Funds") {
        // Do not allow deselection of Cash/Mutual Funds
        return;
      }
      if (selectedSegments.contains(segment)) {
        selectedSegments.remove(segment);
      } else {
        selectedSegments.add(segment);
      }
    });
  }

  /// Saves selected segments to secure storage
  Future<void> _saveSegments() async {
    final List<String> segmentsForApi =
        selectedSegments.map((label) => segmentApiMap[label] ?? label).toList();
    await secureStorage.write(
      key: 'selected_segments',
      value: jsonEncode(segmentsForApi),
    );
  }

  /// Shows bottom sheet for uploading income proof when required
  void _showIncomeProofBottomSheet(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: BoxDecoration(
                color: isDark ? Color(0xff121413) : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upload Income Proof",
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Divider(
                    color: Color(0xFF2F2F2F),
                    thickness: 1,
                  ),
                  SizedBox(height: 16.h),
                  // Document Selection
                  Text(
                    "Select Document",
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: isDark ? Color(0xff121413) : Color(0xFFF4F4F9),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: isDark ? Color(0xFF2F2F2F) : Color(0xFFE5E7EB),
                        width: 1,
                      ),
                    ),
                    child: DropdownButton<String>(
                      value: selectedDocument,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      isExpanded: true,
                      dropdownColor: isDark ? Color(0xff121413) : Colors.white,
                      underline: SizedBox(),
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 14.sp,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedDocument = newValue!;
                        });
                      },
                      items: <String>[
                        "Bank statement (6 mo): Avg. bal. > ₹10K",
                        "Salary slip: Gross > ₹15K/mo",
                        "ITR/Form 16: Gross > ₹1.2L/yr",
                        "Net worth certificate: > ₹10L",
                        "Demat statement: Holdings > ₹10K",
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Upload document section
                  Text(
                    "Upload document",
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  GestureDetector(
                    onTap: () {
                      _pickFile(context, setState);
                    },
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(8.r),
                      dashPattern: [8, 6],
                      color: isDark
                          ? const Color(0xFF2F2F2F)
                          : const Color(0xFFE5E7EB),
                      strokeWidth: 1,
                      child: Container(
                        height: 120.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.transparent,
                        ),
                        child: Center(
                          child: _selectedFile == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 8.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/svgs/update.svg",
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          "Upload a file or ",
                                          style: TextStyle(
                                            color: isDark
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        Text(
                                          "Choose file",
                                          style: TextStyle(
                                            color: isDark
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 14.sp,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      "Supported formats: PDF, JPG, PNG",
                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.grey
                                            : Colors.grey[600],
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _selectedFileName!
                                              .toLowerCase()
                                              .endsWith('.pdf')
                                          ? Icons.picture_as_pdf
                                          : Icons.image,
                                      size: 36,
                                      color: isDark
                                          ? Colors.white
                                          : Colors.black87,
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      _selectedFileName!,
                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14.sp,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 8.h),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedFile = null;
                                          _selectedFileName = null;
                                        });
                                      },
                                      child: Text(
                                        "Remove",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14.sp,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Show upload button when file is selected
                  if (_selectedFile != null) SizedBox(height: 24.h),
                  // Continue button
                  constWidgets.greenButton(
                    "Continue",
                    onTap: (_selectedFile == null)
                        ? null
                        : () async {
                            Navigator.pop(context); // Close bottom sheet
                            await _saveSegments(); // Save segments
                            navi(FamilyDetailsScreen(), context); // Navigate
                          },
                    isDisabled: _selectedFile == null,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 46,
        leading: Padding(
          padding: EdgeInsets.only(left: 0),
          child: IconButton(
            icon: Icon(Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: isDark ? Colors.black : Colors.white,
      ),
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 8.h),
            constWidgets.topProgressBar(1, 3, context),
            SizedBox(height: 24.h),
            Text(
              "Choose Your Investment Segment",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 16.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSelectableChip("Cash/Mutual Funds"),
                    _buildSelectableChip("F&O"),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSelectableChip("Debt"),
                    _buildSelectableChip("Currency"),
                  ],
                ),
                SizedBox(height: 20.h),
                _buildSelectableChip("Commodity Derivatives"),
              ],
            ),
            Spacer(),
            constWidgets.greenButton(
              "Continue",
              onTap: () async {
                // Check if F&O, Currency, or Commodity Derivatives are selected
                bool requiresIncomeProof = selectedSegments.contains("F&O") ||
                    selectedSegments.contains("Currency") ||
                    selectedSegments.contains("Commodity Derivatives");
                if (requiresIncomeProof) {
                  _showIncomeProofBottomSheet(context);
                } else {
                  await _saveSegments(); // Save segments
                  navi(FamilyDetailsScreen(), context); // Navigate
                }
              },
            ),
            SizedBox(height: 10.h),
            Center(child: constWidgets.needHelpButton(context)),
          ],
        ),
      ),
    );
  }

  /// Creates a selectable chip widget for a segment option
  Widget _buildSelectableChip(String segment) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      borderRadius: BorderRadius.circular(25.r),
      onTap:
          segment == "Cash/Mutual Funds" ? null : () => _toggleSegment(segment),
      child: constWidgets.segmentChoiceChipiWithCheckbox(
        segment,
        selectedSegments.contains(segment),
        context,
        isDark,
        isDisabled: segment == "Cash/Mutual Funds",
      ),
    );
  }
}
