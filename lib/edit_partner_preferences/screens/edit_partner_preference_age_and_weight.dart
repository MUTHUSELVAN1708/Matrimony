import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/edit_partner_preferences/riverpod/edit_partner_preference_state.dart';

class AgeSelectionDialog extends ConsumerStatefulWidget {
  final String hint;
  final int? fromValue;
  final int? toValue;

  const AgeSelectionDialog({
    super.key,
    required this.hint,
    this.fromValue,
    this.toValue,
  });

  @override
  AgeSelectionDialogState createState() => AgeSelectionDialogState();
}

class AgeSelectionDialogState extends ConsumerState<AgeSelectionDialog> {
  late int? fromAge;
  late int? toAge;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fromAge = widget.fromValue;
    toAge = widget.toValue;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final edit = ref.watch(editPartnerPreferenceProvider);
    return GestureDetector(
      onTap: () => _showMainDialog(context),
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
                    edit.fromAge == ''
                        ? 'Select'
                        : widget.hint == 'Age'
                            ? '${edit.fromAge} - ${edit.toAge} Yrs'
                            : '${edit.fromWeight} - ${edit.toWeight} Kg',
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.grey.shade600,
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

  void _showMainDialog(BuildContext context) {
    final edit = ref.watch(editPartnerPreferenceProvider);
    fromAge = widget.hint == 'Age'
        ? edit.fromAge.isNotEmpty
            ? int.tryParse(edit.fromAge)
            : null
        : edit.fromWeight.isNotEmpty
            ? int.tryParse(edit.fromWeight)
            : null;
    toAge = widget.hint == 'Age'
        ? edit.toAge.isNotEmpty
            ? int.tryParse(edit.toAge)
            : null
        : edit.toWeight.isNotEmpty
            ? int.tryParse(edit.toWeight)
            : null;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Center(child: Text('Select Age Range')),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => _showSelectionDialog(
                      context,
                      isFromAge: true,
                      currentAge: fromAge,
                    ).then((selectedAge) {
                      if (selectedAge != null) {
                        setState(() {
                          fromAge = selectedAge;
                          if (toAge != null && selectedAge > toAge!) {
                            toAge = null;
                          }
                        });
                      }
                    }),
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'From ${widget.hint}: ',
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            fromAge?.toString() ?? '',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => _showSelectionDialog(
                      context,
                      isFromAge: false,
                      currentAge: toAge,
                      fromAge: fromAge,
                    ).then((selectedAge) {
                      if (selectedAge != null) {
                        setState(() {
                          toAge = selectedAge;
                        });
                      }
                    }),
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('To ${widget.hint}:   ',
                              style: const TextStyle(fontSize: 18)),
                          Text(
                            toAge?.toString() ?? '',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      if (fromAge != null && toAge != null) {
                        if (widget.hint == 'Age') {
                          ref
                              .read(editPartnerPreferenceProvider.notifier)
                              .updateFromAge(fromAge.toString());
                          ref
                              .read(editPartnerPreferenceProvider.notifier)
                              .updateToAge(toAge.toString());
                        } else {
                          ref
                              .read(editPartnerPreferenceProvider.notifier)
                              .updateFromWeight(fromAge.toString());
                          ref
                              .read(editPartnerPreferenceProvider.notifier)
                              .updateToWeight(toAge.toString());
                        }
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: fromAge != null && toAge != null
                            ? AppColors.primaryButtonColor.withOpacity(0.7)
                            : Colors.grey,
                      ),
                      child: const Center(
                        child: Text('Apply',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<int?> _showSelectionDialog(
    BuildContext context, {
    required bool isFromAge,
    int? currentAge,
    int? fromAge,
  }) async {
    final isAge = widget.hint == 'Age';
    final List<int> ageRange = isFromAge
        ? List.generate(isAge ? 50 : 120, (index) => (isAge ? 18 : 40) + index)
        : (fromAge != null
            ? List.generate(isAge ? 50 : 120 - fromAge + (isAge ? 18 : 40),
                (index) => fromAge + index)
            : []);

    return showDialog<int>(
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
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width * 0.85,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Select ${isFromAge ? "From ${widget.hint}" : "To ${widget.hint}"}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ageRange.isEmpty
                          ? Center(
                              child: Text(
                                'Please select "From ${widget.hint}" first.',
                                style: const TextStyle(color: Colors.grey),
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
                                  shrinkWrap: true,
                                  controller: _scrollController,
                                  itemCount: ageRange.length,
                                  itemBuilder: (context, index) {
                                    final age = ageRange[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: ListTile(
                                        leading: currentAge == age
                                            ? const Icon(
                                                Icons.radio_button_checked,
                                                color: Colors.red)
                                            : const Icon(Icons.circle_outlined),
                                        title: Text('$age'),
                                        onTap: () {
                                          Navigator.of(context).pop(age);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
