abstract base class HomePageStates{}

final class HomePageInitialState extends HomePageStates{}

final class HomePageNavBarChangedState extends HomePageStates{}


final class HomePageLoadingState extends HomePageStates{}

final class HomePageGotDataState extends HomePageStates{}

final class HomePageErrorState extends HomePageStates{}



final class HomePageGotCategoriesState extends HomePageStates{}

final class HomePageCategoriesErrorState extends HomePageStates{}




final class HomePageChangeLocalFavoriteState extends HomePageStates{}

final class HomePageSuccessRemoteFavoriteState extends HomePageStates{}

final class HomePageErrorRemoteFavoriteState extends HomePageStates{}
