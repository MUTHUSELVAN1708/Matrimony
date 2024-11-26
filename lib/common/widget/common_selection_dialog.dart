import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/colors.dart';

class CommonSelectionDialog extends ConsumerStatefulWidget {
  final String title;
  final List<String> options;
  final String? selectedValue; // Nullable type
  final Function(String) onSelect;
  final bool removeSearching;

  CommonSelectionDialog(
      {super.key,
      required this.title,
      required this.options,
      this.selectedValue,
      required this.onSelect,
      this.removeSearching = false});

  @override
  ConsumerState<CommonSelectionDialog> createState() =>
      _CommonSelectionDialogState();
}

class _CommonSelectionDialogState extends ConsumerState<CommonSelectionDialog> {
  late String? tempSelected; // Nullable type
  late TextEditingController searchController;
  late List<String> filteredOptions;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    tempSelected = widget.selectedValue; // Handle nullable value
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

  bool otherValue = false;
  final other = TextEditingController();

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
                  widget.removeSearching || otherValue
                      ? const SizedBox()
                      : TextField(
                          controller: searchController,
                          onChanged: filterOptions,
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            prefixIcon:
                                Icon(Icons.search, color: Colors.grey[400]),
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
                  : otherValue
                      ? Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            controller: other,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
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
                              itemBuilder: (context, index) =>
                                  RadioListTile<String>(
                                title: Text(
                                  filteredOptions[index],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        filteredOptions[index] == tempSelected
                                            ? AppColors.primaryButtonColor
                                            : Colors.black,
                                  ),
                                ),
                                value: filteredOptions[index],
                                groupValue: tempSelected,
                                activeColor: Colors.red[400],
                                onChanged: (value) {
                                  setState(() {
                                    tempSelected = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: other.text.isNotEmpty ||
                          (tempSelected != null && tempSelected!.isNotEmpty)
                      ? AppColors.primaryButtonColor
                      : AppColors.statusBarShadowColor,
                  foregroundColor: AppColors.primaryButtonTextColor,
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: (other.text.isNotEmpty ||
                        (tempSelected != null && tempSelected!.isNotEmpty))
                    ? () {
                        if (other.text.isNotEmpty) {
                          // Handle the case where text is entered in the 'other' field
                          widget.onSelect(other.text);
                          Navigator.pop(context);
                        } else if (tempSelected != null) {
                          if (tempSelected == 'other') {
                            // Handle 'other' option being selected
                            setState(() {
                              otherValue = true;
                            });
                          } else {
                            // Handle a valid selection other than 'other'
                            widget.onSelect(tempSelected!);
                            Navigator.pop(context);
                          }
                        }
                      }
                    : null,

                // onPressed:other.text.isNotEmpty? (){
                //   if(other.text.isNotEmpty){
                //     widget.onSelect(other.text);
                //     Navigator.pop(context);
                //   }
                // }: () {
                //     if(tempSelected != null && tempSelected! == 'other'){
                //       setState(() {
                //         otherValue = true;
                //       });
                //     }else {
                //       if (tempSelected != null && tempSelected!.isNotEmpty) {
                //         widget.onSelect(tempSelected!);
                //         Navigator.pop(context);
                //       }
                //     }
                // },
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
