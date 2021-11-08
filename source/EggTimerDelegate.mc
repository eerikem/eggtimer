import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

//! Input handler to stop timer on menu press
class EggTimerDelegate extends WatchUi.BehaviorDelegate {
    private var _view as EggTimerView;

    //! Constructor
    //! @param view The app view
    public function initialize(view as EggTimerView) {
        WatchUi.BehaviorDelegate.initialize();
        _view = view;
    }

    public function onSelect() as Boolean {
        _view.startStopTimer();
        return true;
    }

    public function onBack() as Boolean {
        System.exit();
    }

    public function onNextPage() as Boolean {
        _view.incrementMode();
        return true;
    }

    public function onPreviousPage() as Boolean {
        _view.decrementMode();
        return true;
    }
}