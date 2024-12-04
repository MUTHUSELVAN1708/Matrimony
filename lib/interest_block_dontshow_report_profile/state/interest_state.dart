class InterestState {
  final bool isLoading;
  final String? receiveStatus;
  final String? sentStatus;
  final bool isBlocked;
  final bool isIgnored;

  InterestState(
      {this.isLoading = false,
      this.receiveStatus,
      this.sentStatus,
      this.isBlocked = false,
      this.isIgnored = false});

  factory InterestState.initial() {
    return InterestState(
        isLoading: false,
        receiveStatus: null,
        sentStatus: null,
        isBlocked: false,
        isIgnored: false);
  }

  InterestState copyWith({
    bool? isLoading,
    String? receiveStatus,
    String? sentStatus,
    bool? isIgnored,
    bool? isBlocked,
  }) {
    return InterestState(
        isLoading: isLoading ?? this.isLoading,
        receiveStatus: receiveStatus ?? this.receiveStatus,
        sentStatus: sentStatus ?? this.sentStatus,
        isIgnored: isIgnored ?? this.isIgnored,
        isBlocked: isBlocked ?? this.isBlocked);
  }
}
