import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/interest_accept_reject/riverpod/interest_provider.dart';
import 'package:matrimony/models/interest_model.dart';

class InterestModelState extends Equatable {
  final List<SentModel> sentInterests;
  final List<ReceiveModel> receivedInterests;
  final bool isLoading;

  const InterestModelState({
    this.sentInterests = const [],
    this.receivedInterests = const [],
    this.isLoading = false,
  });

  InterestModelState copyWith({
    List<SentModel>? sentInterests,
    List<ReceiveModel>? receivedInterests,
    bool? isLoading,
  }) {
    return InterestModelState(
      sentInterests: sentInterests ?? this.sentInterests,
      receivedInterests: receivedInterests ?? this.receivedInterests,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [sentInterests, receivedInterests, isLoading];
}

final interestModelProvider =
    NotifierProvider<InterestModelNotifier, InterestModelState>(
  InterestModelNotifier.new,
);
