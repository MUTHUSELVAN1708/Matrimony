import 'package:flutter/material.dart';
import 'package:matrimony/common/colors.dart';

class LocationDropdown extends StatefulWidget {
  final List<String> value;
  final String hint;
  final List<String>? items;
  final Function(List<String>) onChanged;
  final bool isRequired;
  final bool showSearch;

  LocationDropdown({
    Key? key,
    required this.value,
    required this.hint,
    required this.onChanged,
    this.items,
    this.isRequired = true,
    this.showSearch = false,
  }) : super(key: key);

  @override
  State<LocationDropdown> createState() => _LocationDropdownState();
}

class _LocationDropdownState extends State<LocationDropdown> {
  late List<String> selectedValues;
  List<String> filteredItems = [];
  String searchQuery = '';
  bool isSelectAll = false;

  // List of hints that should only allow single selection
  final List<String> singleSelectionHints = [
    'To Age',
    'From Height',
    'From Age',
    'To Height'
  ];

  bool get isSingleSelection => singleSelectionHints.contains(widget.hint);

  @override
  void initState() {
    super.initState();
    selectedValues = List.from(widget.value);
    filteredItems = widget.items ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showSelectionDialog(context),
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedValues.isEmpty
                    ? widget.hint
                    : selectedValues.join(', ').toString(),
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: selectedValues.isEmpty
                      ? Colors.grey.shade600
                      : Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
          ],
        ),
      ),
    );
  }

  void _showSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.zero,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.showSearch) ...[
                        TextField(
                          decoration: InputDecoration(
                            fillColor: AppColors.dialogboxSearchBackground,
                            filled: true,
                            hintText: 'Search...',
                            hintStyle: const TextStyle(
                                color: AppColors.dialogboxSearchTextColor),
                            suffixIcon: const Icon(Icons.search,
                                color: AppColors.dialogboxSearchTextColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                              filteredItems = widget.items!
                                  .where((item) => item
                                      .toLowerCase()
                                      .contains(searchQuery.toLowerCase()))
                                  .toList();
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                      Text(
                        'Select ${widget.hint}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: (widget.showSearch
                                  ? filteredItems.length
                                  : widget.items!.length) +
                              (isSingleSelection ? 0 : 1),
                          itemBuilder: (context, index) {
                            if (!isSingleSelection && index == 0) {
                              return ListTile(
                                onTap: () {
                                  setState(() {
                                    isSelectAll = !isSelectAll;
                                    selectedValues = isSelectAll
                                        ? List.from(widget.items!)
                                        : [];
                                  });
                                },
                                leading: isSelectAll
                                    ? const Icon(
                                        Icons.radio_button_checked_outlined,
                                        color: Colors.red,
                                      )
                                    : const Icon(Icons.circle_outlined),
                                title: const Text("Select All"),
                              );
                            }

                            final itemIndex =
                                isSingleSelection ? index : index - 1;
                            final currentItem = widget.showSearch
                                ? filteredItems[itemIndex]
                                : widget.items![itemIndex];

                            if (isSingleSelection) {
                              return RadioListTile<String>(
                                title: Text(currentItem),
                                value: currentItem,
                                groupValue: selectedValues.isNotEmpty
                                    ? selectedValues.first
                                    : null,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedValues =
                                        value != null ? [value] : [];
                                  });
                                },
                                activeColor: Colors.red,
                              );
                            } else {
                              return ListTile(
                                leading: selectedValues.contains(currentItem)
                                    ? const Icon(
                                        Icons.radio_button_checked,
                                        color: Colors.red,
                                      )
                                    : const Icon(Icons.circle_outlined),
                                title: Text(currentItem),
                                onTap: () {
                                  setState(() {
                                    if (selectedValues.contains(currentItem)) {
                                      selectedValues.remove(currentItem);
                                      isSelectAll = false;
                                    } else {
                                      selectedValues.add(currentItem);
                                      if (selectedValues.length ==
                                          widget.items!.length) {
                                        isSelectAll = true;
                                      }
                                    }
                                  });
                                },
                              );
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              widget.onChanged(selectedValues);
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Apply',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}