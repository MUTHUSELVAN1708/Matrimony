class EditContactState {
  final String? currentEmail;
  final String? newEmail;
  final String? currentPhoneNumber;
  final String? newPhoneNumber;
  final String? whomToContact;
  final String? contactPersonsName;
  final String? availableTimeToCall;
  final String? comments;
  final bool isLoading;

  EditContactState({
    this.currentEmail,
    this.newEmail,
    this.currentPhoneNumber,
    this.newPhoneNumber,
    this.whomToContact,
    this.contactPersonsName,
    this.availableTimeToCall,
    this.comments,
    this.isLoading = false,
  });

  EditContactState copyWith({
    String? currentEmail,
    String? newEmail,
    String? currentPhoneNumber,
    String? newPhoneNumber,
    String? whomToContact,
    String? contactPersonsName,
    String? availableTimeToCall,
    String? comments,
    bool? isLoading,
  }) {
    return EditContactState(
      currentEmail: currentEmail ?? this.currentEmail,
      newEmail: newEmail ?? this.newEmail,
      currentPhoneNumber: currentPhoneNumber ?? this.currentPhoneNumber,
      newPhoneNumber: newPhoneNumber ?? this.newPhoneNumber,
      whomToContact: whomToContact ?? this.whomToContact,
      contactPersonsName: contactPersonsName ?? this.contactPersonsName,
      availableTimeToCall: availableTimeToCall ?? this.availableTimeToCall,
      comments: comments ?? this.comments,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
