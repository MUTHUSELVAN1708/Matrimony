import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/interest_accept_reject/riverpod/interest_provider.dart';
import 'package:matrimony/models/block_dontshow_model.dart';
import 'package:matrimony/models/interest_model.dart';
import 'package:matrimony/models/report_model.dart';
import 'package:matrimony/models/shortlist_model.dart';
import 'package:matrimony/models/view_model.dart';

class InterestModelState extends Equatable {
  final List<SentModel> sentInterests;
  final List<ReceiveModel> receivedInterests;
  final List<BlockModel> blockLists;
  final List<DoNotShowModel> ignoredLists;
  final List<ReportModel> reportLists;
  final List<int> blockedMeList;
  final List<ViewModel> viewList;
  final List<ShortlistModel> shortList;
  final List<ViewModel> viewListToMe;
  final List<ShortlistModel> shortListToMe;
  final bool isLoading;

  const InterestModelState({
    this.sentInterests = const [],
    this.receivedInterests = const [],
    this.blockLists = const [],
    this.ignoredLists = const [],
    this.reportLists = const [],
    this.blockedMeList = const [],
    this.viewList = const [],
    this.shortList = const [],
    this.viewListToMe = const [],
    this.shortListToMe = const [],
    this.isLoading = false,
  });

  InterestModelState copyWith({
    List<SentModel>? sentInterests,
    List<ReceiveModel>? receivedInterests,
    List<BlockModel>? blockLists,
    List<DoNotShowModel>? ignoredLists,
    List<ReportModel>? reportLists,
    List<int>? blockedMeList,
    List<ViewModel>? viewList,
    List<ShortlistModel>? shortList,
    List<ViewModel>? viewListToMe,
    List<ShortlistModel>? shortListToMe,
    bool? isLoading,
  }) {
    return InterestModelState(
      sentInterests: sentInterests ?? this.sentInterests,
      receivedInterests: receivedInterests ?? this.receivedInterests,
      blockLists: blockLists ?? this.blockLists,
      ignoredLists: ignoredLists ?? this.ignoredLists,
      reportLists: reportLists ?? this.reportLists,
      blockedMeList: blockedMeList ?? this.blockedMeList,
      shortList: shortList ?? this.shortList,
      viewList: viewList ?? this.viewList,
      shortListToMe: shortListToMe ?? this.shortListToMe,
      viewListToMe: viewListToMe ?? this.viewListToMe,
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
        blockedMeList,
        viewList,
        shortList,
        viewListToMe,
        shortListToMe,
        isLoading
      ];
}

final interestModelProvider =
    NotifierProvider<InterestModelNotifier, InterestModelState>(
  InterestModelNotifier.new,
);
