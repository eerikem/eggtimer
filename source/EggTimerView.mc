import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Lang;
import Toybox.Attention;

class EggTimerView extends WatchUi.View {

    private var m_start_time as Number = 0; 
    private var m_time as Number = 0;
    private var m_timer as Timer.Timer?;
    // private var m_multiplier as Number = 120;
    private var m_multiplier as Number = 1;
    private var m_modes as Array = [3,30];
    private var m_mode as Number = 1;

    private function getTimerInterval() as Number{
        return m_modes[m_mode];
    }

    function initialize() {
        View.initialize();
        resetTimer();
    }

    public function resetTimer() as Void {
        if (m_timer == null) {
            m_timer = new Timer.Timer();
        }
        m_timer.stop();
        m_timer.start(method(:onTimeout),1000*60/m_multiplier,true);
        m_start_time = Time.now().value();
        m_time = 0;
    }

    public function onTimeout() as Void {
        m_time = Time.now().value() - m_start_time;
        m_time = m_time * m_multiplier;
        var vibeProfiles = [
            new Attention.VibeProfile(50,100)
        ];
        if(m_time % (60 * getTimerInterval()) == 0){
            Attention.vibrate(vibeProfiles);
        }

        WatchUi.requestUpdate();
    }

    // Load your resources here
    // function onLayout(dc as Dc) as Void {
    //     setLayout(Rez.Layouts.MainLayout(dc));
    // }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    // function onShow() as Void {
    // }

    // Update the view
    function onUpdate(dc as Dc) as Void {
    
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        
        var sTime = timeString();
        dc.drawText(dc.getWidth() / 2 - sTime.length() * 5, (dc.getHeight() / 2 - 20), Graphics.FONT_LARGE, sTime, Graphics.TEXT_JUSTIFY_LEFT);
    }

    function timeString() as string {
        
        if (m_time < 60 * 60 ){
            var minutes = m_time / 60;
            return minutes + "min";
        }else{
            var minutes = ( m_time / 60 ) % 60;
            var hours = m_time / 3600;
            return hours + "hr " + minutes + "min";
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    // function onHide() as Void {
    // }

    public function startStopTimer() as Void {
        if (m_timer != null) {
            m_timer.stop();
            m_timer = null;
        }else{
            resetTimer();
            WatchUi.requestUpdate();
        }
    }

    public function incrementMode() as Void {
        m_mode++;
        if (m_mode >= m_modes.size()){
            m_mode = 0;
        }
    }

    public function decrementMode() as Void {
        m_mode--;
        if (m_mode < 0){
            m_mode = m_modes.size() - 1;
        }
    }
}
