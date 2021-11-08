import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

class EggTimerMenuDelegate extends WatchUi.MenuInputDelegate {
    private var _view as EggTimerView;
    public function initialize(view as EggTimerView){
        MenuInputDelegate.initialize();
        _view = view;
    }

    public function onMenuItem(item){
        _view.setTimerMode(item);
        _view.resetTimer();
    }
}

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
        onMenu();
        return true;
    }

    public function onPreviousPage() as Boolean {
        onMenu();
        return true;
    }

    public function onMenu() {
        var menu = new WatchUi.Menu();
        var delegate;
        menu.setTitle("Interval");
        if (_view.getTimerInterval() == 30){
            menu.addItem("30min", :thirty);
            menu.addItem("3min", :three);
        }else{
            menu.addItem("3min", :three);
            menu.addItem("30min", :thirty);
        }
        delegate = new EggTimerMenuDelegate(_view);
        WatchUi.pushView(menu,delegate,WatchUi.SLIDE_UP);
        return true;
    }

}