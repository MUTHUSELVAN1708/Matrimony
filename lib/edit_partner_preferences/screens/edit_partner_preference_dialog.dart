import 'package:flutter/material.dart';
import 'package:matrimony/common/colors.dart';

import '../../user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_basic_screen/partner_basic_widgets/preference_age_dialogBox.dart';

class EditPartnerPreferenceDialog extends StatefulWidget {
  final List<String> value;
  final String hint;
  List<String>? items;
  final Function(List<String>) onChanged;
  final String? hint2;
  final String? hint3;
  final bool isRequired;
  final bool ageheight;

  EditPartnerPreferenceDialog({
    super.key,
    required this.value,
    required this.hint,
    required this.onChanged,
    this.items,
    this.hint2,
    this.hint3,
    this.isRequired = true,
    this.ageheight = false,
  });

  @override
  State<EditPartnerPreferenceDialog> createState() =>
      _AgeCustomDialogBoxState();
}

class _AgeCustomDialogBoxState extends State<EditPartnerPreferenceDialog> {
  late List<String> selectedValues;
  bool isSelectAll = false;
  final List<String> singleSelectionHints = [
    'To Age',
    'From Height',
    'From Age',
    'To Height',
    'From Weight',
    'To Weight'
  ];

  bool get isSingleSelection => singleSelectionHints.contains(widget.hint);

  @override
  void initState() {
    super.initState();
    selectedValues = List.from(widget.value);
    print('Ada gommala');
    print(selectedValues);
    // fromItem = [widget.value.first];
    // toItem = [widget.value.last];
  }

  List<String> toItem = [];
  List<String> fromItem = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showSelectionDialog(context),
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.hint,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    selectedValues.isEmpty
                        ? 'Select'
                        : widget.hint == 'Age' ||
                                widget.hint == 'Height' ||
                                widget.hint == 'Weight'
                            ? "${fromItem.isNotEmpty ? '${fromItem[0]} ' '${widget.hint == 'Age' ? 'Yrs' : 'Kg'}' : ''} - ${toItem.isNotEmpty ? '${toItem[0]} ' '${widget.hint == 'Age' ? 'Yrs' : 'Kg'}' : ''}"
                            : selectedValues.join(', '),
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: selectedValues.isEmpty
                          ? Colors.grey.shade600
                          : Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade600),
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
              return Stack(children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  height: widget.ageheight
                      ? MediaQuery.of(context).size.height * 0.30
                      : MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.85,
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
                        widget.ageheight
                            ? SingleChildScrollView(
                                child: Column(
                                  children: [
                                    AgeCustomDialogBox(
                                      value: fromItem,
                                      hint: widget.hint2 ?? '',
                                      items: widget.items,
                                      onChanged: (data) {
                                        setState(() {
                                          fromItem = data;
                                          toItem.clear();
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    if (fromItem.isNotEmpty)
                                      AgeCustomDialogBox(
                                        value: toItem,
                                        hint: widget.hint3 ?? '',
                                        items: widget.items!
                                            .where((item) =>
                                                int.parse(item) >
                                                int.parse(fromItem[0]))
                                            .toList(),
                                        onChanged: (data) {
                                          setState(() {
                                            toItem = data;
                                          });
                                        },
                                      ),
                                  ],
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: (isSingleSelection
                                      ? widget.items!.length
                                      : widget.items!.length + 1),
                                  itemBuilder: (context, index) {
                                    if (!isSingleSelection && index == 0) {
                                      return ListTile(
                                        onTap: () {
                                          setState(() {
                                            isSelectAll = !isSelectAll;
                                            if (isSelectAll) {
                                              selectedValues =
                                                  List.from(widget.items!);
                                            } else {
                                              selectedValues.clear();
                                            }
                                          });
                                        },
                                        leading: isSelectAll
                                            ? const Icon(
                                                Icons
                                                    .radio_button_checked_outlined,
                                                color: Colors.red,
                                              )
                                            : const Icon(Icons.circle_outlined),
                                        title: const Text("Select All"),
                                      );
                                    }
                                    final itemIndex =
                                        isSingleSelection ? index : index - 1;
                                    final currentItem =
                                        widget.items![itemIndex];

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
                                        leading: selectedValues
                                                .contains(currentItem)
                                            ? const Icon(
                                                Icons.radio_button_checked,
                                                color: Colors.red,
                                              )
                                            : const Icon(Icons.circle_outlined),
                                        title: Text(currentItem),
                                        onTap: () {
                                          setState(() {
                                            if (selectedValues
                                                .contains(currentItem)) {
                                              selectedValues
                                                  .remove(currentItem);
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
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: fromItem.isNotEmpty && toItem.isEmpty
                            ? null
                            : () {
                                if (fromItem.isNotEmpty && toItem.isNotEmpty) {
                                  selectedValues = ["$fromItem $toItem"];
                                  widget.onChanged(selectedValues);
                                } else {
                                  widget.onChanged(selectedValues);
                                }
                                Navigator.pop(context);
                              },
                        style: ElevatedButton.styleFrom(
                          disabledIconColor:
                              fromItem.isNotEmpty && toItem.isEmpty
                                  ? Colors.grey
                                  : Colors.red,
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
                ),
              ]);
            },
          ),
        );
      },
    );
  }
}
