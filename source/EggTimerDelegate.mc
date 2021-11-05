import Toybox.Lang;
import Toybox.WatchUi;

//! Input handler to stop timer on menu press
class EggTimerDelegate extends WatchUi.BehaviorDelegate {
    private var _view as EggTimerView;

    //! Constructor
    //! @param view The app view
    public function initialize(view as EggTimerView) {
        WatchUi.BehaviorDelegate.initialize();
        _view = view;
    }

    //! Stop the first timer on menu event
    //! @return true if handled, false otherwise
    public function onMenu() as Boolean {
        _view.stopTimer();
        return true;
    }
}