import 'package:flutter/material.dart';
import 'package:matrimony/common/colors.dart';

class CustomDropdownField extends StatefulWidget {
  final String value;
  final String hint;
  final List<String> items;
  final Function(String) onChanged;
  final bool isRequired;

  const CustomDropdownField({
    Key? key,
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.isRequired = true,
  }) : super(key: key);

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  late String selectedValue;
  List<String> filteredItems = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
    filteredItems = widget.items;
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
                selectedValue.isEmpty ? widget.hint : selectedValue,
                style: TextStyle(
                  color: selectedValue.isEmpty
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
    setState(() {
      filteredItems = widget.items;
      searchQuery = '';
    });

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
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                            filteredItems = widget.items
                                .where((item) => item
                                    .toLowerCase()
                                    .contains(searchQuery.toLowerCase()))
                                .toList();
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Select ${widget.hint}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (filteredItems.isEmpty)
                        const Expanded(
                            child: Center(
                          child: Text(
                            'No Result Found',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ))
                      else
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: filteredItems.length,
                            itemBuilder: (context, index) {
                              return RadioListTile<String>(
                                title: Text(filteredItems[index]),
                                value: filteredItems[index],
                                groupValue: selectedValue,
                                activeColor: Colors.red,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      selectedValue = newValue;
                                    });
                                  }
                                },
                              );
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
                              widget.onChanged(selectedValue);
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
