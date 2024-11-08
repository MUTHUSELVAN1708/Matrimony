import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/colors.dart';

class CommonSelectionDialog extends ConsumerStatefulWidget {
  final String title;
  final List<String> options;
  final String selectedValue;
  final Function(String) onSelect;

  const CommonSelectionDialog({
    super.key,
    required this.title,
    required this.options,
    required this.selectedValue,
    required this.onSelect,
  });

  @override
  ConsumerState<CommonSelectionDialog> createState() =>
      _CommonSelectionDialogState();
}

class _CommonSelectionDialogState extends ConsumerState<CommonSelectionDialog> {
  late String tempSelected;
  late TextEditingController searchController;
  late List<String> filteredOptions;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    tempSelected = widget.selectedValue;
    searchController = TextEditingController();
    filteredOptions = widget.options;
  }

  @override
  void dispose() {
    searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void filterOptions(String query) {
    setState(() {
      filteredOptions = widget.options
          .where((option) => option.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
          maxWidth: MediaQuery.of(context).size.width * 0.9,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Column(
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: searchController,
                    onChanged: filterOptions,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                      filled: true,
                      fillColor: Colors.grey[50],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[200]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[200]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.red[100]!),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: filteredOptions.isEmpty
                  ? Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                    )
                  : Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: RawScrollbar(
                        thumbColor: AppColors.primaryButtonColor,
                        controller: _scrollController,
                        thumbVisibility: true,
                        radius: const Radius.circular(16),
                        thickness: 8,
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: filteredOptions.length,
                          itemBuilder: (context, index) => RadioListTile<String>(
                            title: Text(
                              filteredOptions[index],
                              style: TextStyle(
                                fontSize: 16,
                                color: filteredOptions[index] == tempSelected
                                    ? AppColors.primaryButtonColor
                                    : Colors.black, // Change color based on selection
                              ),
                            ),
                            value: filteredOptions[index],
                            groupValue: tempSelected,
                            activeColor: Colors.red[400],
                            onChanged: (value) {
                              setState(() {
                                tempSelected = value!;
                              });
                            },
                          ),
                        ),
                      ),
                  ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                // border: Border(
                //   top: BorderSide(color: Colors.grey[200]!),
                // ),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryButtonColor,
                  foregroundColor: AppColors.primaryButtonTextColor,
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (tempSelected.isNotEmpty) {
                    widget.onSelect(tempSelected);
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Apply',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
