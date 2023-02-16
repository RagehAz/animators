part of animators;

class Animators {
  // -----------------------------------------------------------------------------

  const Animators();

  // -----------------------------------------------------------------------------

  /// SWIPE DIRECTION

  // --------------------
  static SwipeDirection getSwipeDirection({
    @required int oldIndex,
    @required int newIndex
  }) {
    SwipeDirection _swipeDirection;

    if (newIndex > oldIndex) {
      _swipeDirection = SwipeDirection.next;
    }

    else if (newIndex < oldIndex) {
      _swipeDirection = SwipeDirection.back;
    }

    else {
      _swipeDirection = SwipeDirection.freeze;
    }

    // print('getSwipeDirection concluded going from [ old index ($oldIndex) ] to [ new index ($newIndex) ] is [$_swipeDirection]');
    return _swipeDirection;
  }
  // -----------------------------------------------------------------------------

  /// PAGE CONTROLLERS

  // --------------------
  /*
  static void disposePageControllerIfPossible(PageController controller) {
    if (controller != null) {
      controller.dispose();
    }
  }
   */
  // --------------------
  /*
  static void disposeScrollControllerIfPossible(ScrollController controller) {
    if (controller != null) {
      controller.dispose();
    }
  }
   */
  // -----------------------------------------------------------------------------

  /// Animation<double>

  // --------------------
  static Animation<double> animateDouble({
    @required double begin,
    @required double end,
    @required AnimationController controller,
    Cubic curve = Curves.easeIn,
    Cubic reverseCurve = Curves.easeIn,
  }) {

    return Tween<double>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: curve,
      reverseCurve: reverseCurve,
    ));

    /// can do stuff here
    //   ..addListener(() {
    //   // setState(() {
    //   //
    //   // });
    // })
    //   ..addStatusListener((status) {
    //     // if (status == AnimationStatus.completed) {
    //     //   _controller.reverse();
    //     // } else if (status == AnimationStatus.dismissed) {
    //     //   _controller.forward();
    //     // }
    //   })

  }
  // -----------------------------------------------------------------------------

  /// TWEEN MODS

  // --------------------
  /// TESTED : WORKS PERFECT
  static double limitTweenImpact({
    @required double maxDouble,
    @required double minDouble,
    @required double tweenValue, // 0 -> 1
  }){

    assert(minDouble <= maxDouble, 'limitTweenImpact : minDouble can not be bigger than maxDouble');

    /// NOTE : THIS LIMITS THE IMPACT OF TWEEN VALUE TO AFFECT ONLY PART OF THE GIVEN SIZE (MAX DOUBLE)
    /// AS IT FIXES THE MINIMUM

    return minDouble + ((maxDouble - minDouble) * tweenValue);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getInverseTweenValue({
    @required double tweenValue,
  }){

    return 1 - tweenValue;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadiusTween tweenCorners({
    @required BorderRadius begin,
    @required BorderRadius end,
    BorderRadiusTween cornerTween,
  }){

    return BorderRadiusTween(
      begin: begin,
      end: end,
    );

  }
  // -----------------------------------------------------------------------------
}
