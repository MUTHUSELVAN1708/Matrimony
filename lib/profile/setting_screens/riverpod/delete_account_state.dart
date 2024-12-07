import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/profile/setting_screens/riverpod/delete_account_notifier.dart';

class DeleteAccountState {
  final String reason;
  final String alreadyMarried;
  final String siteName;
  final String sourceName;
  final String decision;
  final String otherDecision;
  final String name;
  final String weddingDate;
  final String image;
  final String successStory;
  final bool isLoading;

  DeleteAccountState({
    this.reason = '',
    this.alreadyMarried = '',
    this.siteName = '',
    this.sourceName = '',
    this.decision = '',
    this.otherDecision = '',
    this.name = '',
    this.weddingDate = '',
    this.image = '',
    this.successStory = '',
    this.isLoading = false,
  });

  DeleteAccountState copyWith({
    String? reason,
    String? alreadyMarried,
    String? siteName,
    String? sourceName,
    String? decision,
    String? otherDecision,
    String? name,
    String? weddingDate,
    String? image,
    String? successStory,
    bool? isLoading,
  }) {
    return DeleteAccountState(
      reason: reason ?? this.reason,
      alreadyMarried: alreadyMarried ?? this.alreadyMarried,
      siteName: siteName ?? this.siteName,
      sourceName: sourceName ?? this.sourceName,
      decision: decision ?? this.decision,
      otherDecision: otherDecision ?? this.otherDecision,
      name: name ?? this.name,
      weddingDate: weddingDate ?? this.weddingDate,
      image: image ?? this.image,
      successStory: successStory ?? this.successStory,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final deleteAccountProvider =
    StateNotifierProvider<DeleteAccountNotifier, DeleteAccountState>(
  (ref) => DeleteAccountNotifier(),
);
