part of animators;

enum SwipeDirection {
  next,
  back,
  freeze,
}

class Sliders {
  // -----------------------------------------------------------------------------

  const Sliders();

  // -----------------------------------------------------------------------------

  /// SLIDE TO

  // --------------------
  static Future<int> slideToNextAndGetNewIndex({
    @required PageController slidingController,
    @required int numberOfSlides,
    @required int currentSlide,
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.easeInOutCirc,
  }) async {

    if (currentSlide + 1 == numberOfSlides) {
      // blog('Can not slide forward');
      return currentSlide;
    }
    else {

      await slidingController.animateToPage(currentSlide + 1,
          duration: duration,
          curve: curve
      );

      return currentSlide + 1;
    }
  }
  // --------------------
  static Future<int> slideToBackAndGetNewIndex({
    @required PageController pageController,
    @required int currentSlide,
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.easeInOutCirc,
  }) async {

    /// this checks if its the first slide, it won't change index and won't slide, otherwise
    /// will slide back and return decreased index

    if (currentSlide == 0) {
      // blog('can not slide back');
      return currentSlide;
    }

    else {

      await pageController.animateToPage(currentSlide - 1,
          duration: duration,
          curve: curve,
      );

      return currentSlide - 1;
    }
  }
  // --------------------
  static Future<void> slideToNext({
    @required PageController pageController,
    @required int numberOfSlides,
    @required int currentSlide,
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.easeInOutCirc,
  }) async {

    await pageController.animateToPage(currentSlide + 1,
      duration: duration,
      curve: curve,
    );

  }
  // --------------------
  static Future<void> slideToBackFrom({
    @required PageController pageController,
    @required int currentSlide,
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.easeInOutCirc,
  }) async {

    if (currentSlide == 0) {
      // blog('can not slide back');
    }

    else {
      await pageController.animateToPage(
        currentSlide - 1,
        duration: duration,
        curve: curve,
      );
    }

  }
  // --------------------
  /// never used
  /*
  //   Future<void> snapToBack(PageController slidingController, int currentSlide) async {
  //
  //   if (currentSlide == 0){
  //     blog('can not slide back');
  //   }
  //
  //   else {
  //     await slidingController.jumpToPage(currentSlide - 1);
  //   }
  // }
  */
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> slideToIndex({
    @required PageController pageController,
    @required int toIndex,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOutCirc,
  }) async {

    if (pageController != null && toIndex != null) {

      await pageController.animateToPage(toIndex,
          duration: duration,
          curve: curve,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> slideToOffset({
  @required ScrollController scrollController,
    @required double offset,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOutCirc,
}) async {

    if (scrollController != null && offset != null) {

      if (scrollController.hasClients == true && scrollController.offset != offset) {

        await scrollController.animateTo(offset,
            duration: duration, curve: curve
        );

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// SNAP TO

  // --------------------
  static void snapTo({
    @required PageController pageController,
    @required int currentSlide
  }) {

    pageController.jumpToPage(
      currentSlide,
    );

  }
  // -----------------------------------------------------------------------------

  /// CONCLUDERS

  // --------------------
  static SwipeDirection slidingDecision(int numberOfSlides, int currentSlide) {

    if (numberOfSlides == 0){
      return SwipeDirection.freeze;
    }
    else if (numberOfSlides == 1){
      return SwipeDirection.freeze;
    }
    else if (numberOfSlides > 1 && currentSlide + 1 == numberOfSlides){
      return SwipeDirection.back;
    }
    else if (numberOfSlides > 1 && currentSlide == 0){
      return SwipeDirection.next;
    }
    else {
      return SwipeDirection.back;
    }

  }
  // --------------------
  static Future<void> slidingAction({
    @required PageController slidingController,
    @required int numberOfSlides,
    @required int currentSlide,
  }) async {

    // blog('i: $currentSlide || #: $numberOfSlides || -> before slidingAction');

    final SwipeDirection _direction = slidingDecision(numberOfSlides, currentSlide);

    if (_direction == SwipeDirection.next){
      await slideToNext(
          pageController: slidingController,
          numberOfSlides: numberOfSlides,
          currentSlide: currentSlide
      );
    }

    else if (_direction == SwipeDirection.back){
      await slideToBackFrom(
          pageController: slidingController,
          currentSlide: currentSlide
      );
    }
    else if (_direction == SwipeDirection.freeze){
      await slideToIndex(
          pageController: slidingController,
          toIndex: currentSlide
      );
    }
    else {
      // blog('no sliding possible ');
    }

  }
  // -----------------------------------------------------------------------------
}
