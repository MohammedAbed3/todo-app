abstract class NewsStates {}

class NewsInitialState extends NewsStates{}
class NewsChangeBottomNavState extends NewsStates {}
class NewsGetBusinessSuccessStates extends NewsStates {}
class NewsGetSportsSuccessStates extends NewsStates {}
class NewsGetSciencesSuccessStates extends NewsStates {}
class NewsGetSearchSuccessStates extends NewsStates {}
class NewsGetBusinessLoadingStates extends NewsStates {}
class NewsGetSportsLoadingStates extends NewsStates {}
class NewsGetSciencesLoadingStates extends NewsStates {}
class NewsGetSearchLoadingStates extends NewsStates {}
class NewsChangeModeStates extends NewsStates {}
class NewsGetSearchEmptyStates extends NewsStates {}
class NewsGetSportsErrorStates extends NewsStates {
  final String? error;

  NewsGetSportsErrorStates(this.error);
}
class NewsGetSearchErrorStates extends NewsStates {
  final String? error;

  NewsGetSearchErrorStates(this.error);
}
class NewsGetSciencesErrorStates extends NewsStates {
  final String? error;

  NewsGetSciencesErrorStates(this.error);
}
class NewsGetBusinessErrorStates extends NewsStates {
  final String? error;

  NewsGetBusinessErrorStates(this.error);
}
