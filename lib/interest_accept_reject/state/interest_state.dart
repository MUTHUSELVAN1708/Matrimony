import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/interest_accept_reject/riverpod/interest_provider.dart';
import 'package:matrimony/models/block_dontshow_model.dart';
import 'package:matrimony/models/interest_model.dart';
import 'package:matrimony/models/report_model.dart';

class InterestModelState extends Equatable {
  final List<SentModel> sentInterests;
  final List<ReceiveModel> receivedInterests;
  final List<BlockModel> blockLists;
  final List<DoNotShowModel> ignoredLists;
  final List<ReportModel> reportLists;
  final bool isLoading;

  const InterestModelState({
    this.sentInterests = const [],
    this.receivedInterests = const [],
    this.blockLists = const [],
    this.ignoredLists = const [],
    this.reportLists = const [],
    this.isLoading = false,
  });

  InterestModelState copyWith({
    List<SentModel>? sentInterests,
    List<ReceiveModel>? receivedInterests,
    List<BlockModel>? blockLists,
    List<DoNotShowModel>? ignoredLists,
    List<ReportModel>? reportLists,
    bool? isLoading,
  }) {
    return InterestModelState(
      sentInterests: sentInterests ?? this.sentInterests,
      receivedInterests: receivedInterests ?? this.receivedInterests,
      blockLists: blockLists ?? this.blockLists,
      ignoredLists: ignoredLists ?? this.ignoredLists,
      reportLists: reportLists ?? this.reportLists,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        sentInterests,
        receivedInterests,
        blockLists,
        ignoredLists,
        reportLists,
        isLoading
      ];
}

final interestModelProvider =
    NotifierProvider<InterestModelNotifier, InterestModelState>(
  InterestModelNotifier.new,
);
