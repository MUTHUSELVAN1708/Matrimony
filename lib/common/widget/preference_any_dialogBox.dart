import 'package:flutter/material.dart';

class AnyCustomPreferenceDropdown extends StatefulWidget {
  final List<String> value;
  final String hint;
  final List<String>? items;
  final Function(List<String>) onChanged;

  AnyCustomPreferenceDropdown({
    Key? key,
    required this.value,
    required this.hint,
    required this.onChanged,
    this.items,
  }) : super(key: key);

  @override
  State<AnyCustomPreferenceDropdown> createState() =>
      _AnyCustomDropdownFieldState();
}

class _AnyCustomDropdownFieldState extends State<AnyCustomPreferenceDropdown> {
  late List<String> selectedValues;
  List<String> filteredItems = [];

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
                    : selectedValues.join(', '),
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
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                          itemCount: widget.items!.length + 1,
                          itemBuilder: (context, index) {
                            String currentItem;

                            if (index == 0) {
                              currentItem = 'Any';
                            } else {
                              currentItem = widget.items![index - 1];
                            }

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
                                  if (currentItem == 'Any') {
                                    selectedValues = ['Any'];
                                  } else {
                                    selectedValues.clear();
                                    selectedValues.add(currentItem);
                                  }
                                });
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
