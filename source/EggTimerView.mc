import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Lang;
import Toybox.Attention;

class EggTimerView extends WatchUi.View {

    private var m_start_time as Number = 0; 
    private var m_time as Number = 0;
    private var m_timer as Timer.Timer?;

    function initialize() {
        View.initialize();

        m_timer = new Timer.Timer();
        m_timer.start(method(:onTimeout),1000*60,true);

        m_start_time = Time.now().value();
    }

    public function onTimeout() as Void {
        m_time = Time.now().value() - m_start_time;
        var vibeProfiles = [
            new Attention.VibeProfile(50,100)
        ];
        if(m_time % (60 * 30) == 0){
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
        
        var minutes = m_time / 60;

        var string = "Working: " + minutes + "min";
        dc.drawText(20, (dc.getHeight() / 2 - 10), Graphics.FONT_LARGE, string, Graphics.TEXT_JUSTIFY_LEFT);
    
        // Call the parent onUpdate function to redraw the layout
        //View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    // function onHide() as Void {
    // }

    public function stopTimer() as Void {
        if (m_timer != null) {
            m_timer.stop();
        }
    }

}
