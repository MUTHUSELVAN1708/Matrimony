import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/common_selection_dialog.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/common/widget/custom_text_field.dart';
import 'package:matrimony/common/widget/full_screen_loader.dart';
import 'package:matrimony/edit/profile/data/profile_options.dart';
import 'package:matrimony/edit/profile/providers/edit_contact_provider.dart';
import 'package:matrimony/edit/profile/state/edit_contact_state.dart';
import 'package:matrimony/models/riverpod/usermanagement_state.dart';

class EditConatctScreen extends ConsumerStatefulWidget {
  const EditConatctScreen({
    super.key,
  });

  @override
  ConsumerState<EditConatctScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends ConsumerState<EditConatctScreen> {
  final contactController = TextEditingController();
  final commentsController = TextEditingController();
  final newEmailController = TextEditingController();
  final newPhoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getValues();
  }

  Future<void> getValues() async {
    await Future.delayed(Duration.zero);
    ref.read(editContactProvider.notifier).disposeState();
    ref
        .read(editContactProvider.notifier)
        .setContactDetails(ref.read(userManagementProvider).userDetails);
    contactController.text =
        ref.read(editContactProvider).contactPersonsName ?? '';
    commentsController.text = ref.read(editContactProvider).comments ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final heightQuery = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final editContactState = ref.watch(editContactProvider);
    return EnhancedLoadingWrapper(
      isLoading: editContactState.isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Contact Details',
            style: TextStyle(color: AppColors.primaryButtonColor),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.primaryButtonColor,
              )),
        ),
        body: Material(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          'email is not editable*',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primaryButtonColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  _buildTextField(
                      'Current Email',
                      editContactState.currentEmail ?? '',
                      false,
                      null,
                      null,
                      null,
                      null),
                  // _buildTextField('Enter your new Email address', '',
                  //     true, null, null, (value) {
                  //   ref
                  //       .read(editContactProvider.notifier)
                  //       .updateNewEmail(value);
                  // }, newEmailController),
                  const SizedBox(
                    height: 5,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Current Contact Number',
                      style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  _buildTextField(
                      'Current contact number',
                      editContactState.currentPhoneNumber ?? '',
                      false,
                      null,
                      null,
                      null,
                      null),
                  const SizedBox(
                    height: 5,
                  ),
                  _buildTextField(
                      'Enter your new contact number',
                      '',
                      true,
                      [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      TextInputType.number, (value) {
                    ref
                        .read(editContactProvider.notifier)
                        .updateNewPhoneNumber(value);
                  }, newPhoneNumberController),
                  const SizedBox(height: 16),
                  const Text(
                    'Contact Preference',
                    style: TextStyle(
                      color: AppColors.primaryButtonColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildListTile(context, ref, editContactState),
                  _buildListTileForTime(context, ref, editContactState),
                  const Text(
                    'Contact Person\'s Name',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  TextField(
                    onChanged: (value) {
                      ref
                          .read(editContactProvider.notifier)
                          .updateContactPersonsName(value);
                    },
                    controller: contactController,
                    decoration: InputDecoration(
                      hintText: 'Enter name',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey), // Gray border
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey), // Gray border
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey), // Gray border
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior
                          .never, // Label disappears when typing
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Comments', style: TextStyle(fontSize: 16)),
                  const SizedBox(
                    height: 6,
                  ),
                  TextField(
                    maxLines: 3,
                    onChanged: (value) {
                      ref
                          .read(editContactProvider.notifier)
                          .updateComments(value);
                    },
                    controller: commentsController,
                    decoration: InputDecoration(
                      hintText: 'Enter comments',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey), // Gray border
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey), // Gray border
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey), // Gray border
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior
                          .never, // Label disappears when typing
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () async {
                        final validation = ref
                            .read(editContactProvider.notifier)
                            .validateContactDetails();
                        if (validation == '') {
                          final result = await ref
                              .read(editContactProvider.notifier)
                              .updateContactDetails();
                          ref
                              .read(userManagementProvider.notifier)
                              .updateContactDetails(editContactState);
                          if (result == 'Success') {
                            Future.delayed(const Duration(microseconds: 50),
                                () {
                              Navigator.pop(context);
                            }).then((_) {
                              CustomSnackBar.show(
                                isError: false,
                                context: context,
                                message:
                                    'Contact Details updated successfully!',
                              );
                            });
                          } else {
                            CustomSnackBar.show(
                              isError: true,
                              context: context,
                              message: result,
                            );
                          }
                        } else {
                          CustomSnackBar.show(
                            isError: true,
                            context: context,
                            message: validation,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hintText,
    String initialValue,
    bool isEnabled,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboard,
    void Function(String)? onChanged,
    TextEditingController? controller,
  ) {
    return CustomTextFieldWidget(
      hintText: hintText,
      initialValue: initialValue,
      isEnabled: isEnabled,
      inputFormatters: inputFormatters,
      keyboardType: keyboard,
      onChanged: onChanged,
      controller: controller,
    );
  }

  Widget _buildListTile(
      BuildContext context, WidgetRef ref, EditContactState editContactState) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Whom To Contact',
            options: ProfileOptions.whomToContact,
            selectedValue: editContactState.whomToContact,
            onSelect: (value) {
              ref.read(editContactProvider.notifier).updateWhomToContact(value);
            },
          ),
        );
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('Whom To Contact'),
        subtitle: Text(
          editContactState.whomToContact ?? 'Select',
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }

  Widget _buildListTileForTime(
      BuildContext context, WidgetRef ref, EditContactState editContactState) {
    return GestureDetector(
      onTap: () async {
        final editContactState = ref.read(editContactProvider);
        final TimeOfDay? selectedTime = await showTimePicker(
          context: context,
          initialTime: editContactState.availableTimeToCall != null
              ? convertStringToTimeOfDay(editContactState.availableTimeToCall!)
              : TimeOfDay.now(),
        );
        if (selectedTime != null) {
          final String formattedTime = selectedTime.format(context);
          ref
              .read(editContactProvider.notifier)
              .updateAvailableTimeToCall(formattedTime);
        }
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('Available Time To Call'),
        subtitle: Text(
          editContactState.availableTimeToCall ?? 'Select',
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }

  TimeOfDay convertStringToTimeOfDay(String timeString) {
    final DateFormat format = DateFormat('hh:mm a');
    final DateTime dateTime = format.parse(timeString);
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }
}
