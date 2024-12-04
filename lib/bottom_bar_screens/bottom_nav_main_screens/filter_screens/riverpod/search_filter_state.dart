import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/filter_screens/model/search_model.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/filter_screens/riverpod/search_filter_provider.dart';
import 'package:matrimony/interest_accept_reject/riverpod/interest_provider.dart';
import 'package:matrimony/models/interest_model.dart';

class SearchFilterState extends Equatable {
  final List<SearchModel> searchModels;
  final bool isLoading;

  const SearchFilterState({
    this.searchModels = const [],
    this.isLoading = false,
  });

  SearchFilterState copyWith({
    List<SearchModel>? searchModels,
    bool? isLoading,
  }) {
    return SearchFilterState(
      searchModels: searchModels ?? this.searchModels,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [searchModels, isLoading];
}

final searchFilterProvider =
    NotifierProvider<SearchFilterProvider, SearchFilterState>(
  SearchFilterProvider.new,
);
