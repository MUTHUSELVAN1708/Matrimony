class InterestState {
  final bool isLoading;
  final String? receiveStatus;
  final String? sentStatus;

  InterestState({this.isLoading = false, this.receiveStatus, this.sentStatus});

  factory InterestState.initial() {
    return InterestState(
        isLoading: false, receiveStatus: null, sentStatus: null);
  }

  InterestState copyWith({
    bool? isLoading,
    String? receiveStatus,
    String? sentStatus,
  }) {
    return InterestState(
        isLoading: isLoading ?? this.isLoading,
        receiveStatus: receiveStatus ?? this.receiveStatus,
        sentStatus: sentStatus ?? this.sentStatus);
  }
}
