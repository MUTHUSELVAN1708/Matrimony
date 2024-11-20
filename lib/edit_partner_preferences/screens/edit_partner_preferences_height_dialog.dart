import 'package:flutter/material.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_basic_screen/partner_basic_widgets/prefarence_height_comment_box.dart';

class EditPartnerPreferencesHeightDialog extends StatefulWidget {
  final List<String> value;
  final String hint;
  List<String>? items;
  final Function(List<String>) onChanged;
  final String? hint2;
  final String? hint3;
  final bool isRequired;
  final bool ageheight;

  EditPartnerPreferencesHeightDialog({
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
  State<EditPartnerPreferencesHeightDialog> createState() =>
      _HeightDropdownFieldState();
}

class _HeightDropdownFieldState
    extends State<EditPartnerPreferencesHeightDialog> {
  late List<String> selectedValues;
  List<String> filteredItems = [];
  bool isSelectAll = false;

  final List<String> singleSelectionHints = ['From Height', 'To Height'];

  bool get isSingleSelection => singleSelectionHints.contains(widget.hint);

  @override
  void initState() {
    super.initState();
    selectedValues = List.from(widget.value);
    filteredItems = widget.items!;
  }

  List<String> toItem = [];
  List<String> fromItem = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showSelectionDialog(context, widget.ageheight),
      child: Container(
        height: 60,
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
                  const Text(
                    'Height',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    selectedValues.isEmpty
                        ? 'Select'
                        : widget.hint == 'Age' || widget.hint == 'Height'
                            ? "${fromItem.isNotEmpty ? fromItem[0] : ''} - ${toItem.isNotEmpty ? toItem[0] : ''}"
                            : selectedValues.join(', ').toString(),
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

  void _showSelectionDialog(BuildContext context, bool ageHeight) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool select = false;
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
                      ? MediaQuery.of(context).size.height * 0.35
                      : MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  HeightDropdownField(
                                    value: fromItem,
                                    hint: widget.hint2 ?? '',
                                    items: widget.items,
                                    onChanged: (data) {
                                      setState(() {
                                        fromItem = data;
                                        toItem.clear();
                                        if (fromItem.isNotEmpty) {
                                          int fromIndex = widget.items!
                                              .indexOf(fromItem.first);
                                          filteredItems = widget.items!
                                              .sublist(fromIndex + 1);
                                        }
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  fromItem.isEmpty
                                      ? const SizedBox()
                                      : HeightDropdownField(
                                          value: toItem.isEmpty ? [] : toItem,
                                          hint: widget.hint3 ?? '',
                                          items: filteredItems,
                                          onChanged: (data) {
                                            setState(() {
                                              toItem = data;
                                            });
                                          },
                                        ),
                                ],
                              )
                            : Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: widget.items!.length +
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
                                            select = !select;
                                            if (select) {
                                              selectedValues.add(currentItem);
                                              if (selectedValues.length ==
                                                  widget.items!.length) {
                                                isSelectAll = true;
                                              }
                                            } else {
                                              selectedValues
                                                  .remove(currentItem);
                                              isSelectAll = false;
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
                        onPressed: () {
                          if (fromItem.isNotEmpty && toItem.isNotEmpty) {
                            selectedValues = ["${fromItem[0]} - ${toItem[0]}"];
                            widget.onChanged(selectedValues);
                          } else {
                            widget.onChanged(selectedValues);
                          }
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
                ),
              ]);
            },
          ),
        );
      },
    );
  }
}
