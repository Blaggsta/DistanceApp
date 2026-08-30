import Toybox.WatchUi;
import Toybox.Graphics;

class DistanceAppView extends WatchUi.View {

    private var _status = "Press UP";
    private var _distance = "";
    private var _speed = 0;


    function initialize() {
        View.initialize();
    }


    function onUpdate(dc as Dc) as Void {

        dc.setColor(
            Graphics.COLOR_WHITE,
            Graphics.COLOR_BLACK
        );

        dc.clear();

        var width = dc.getWidth();

        dc.drawText(
            width / 2,
            35,
            Graphics.FONT_MEDIUM,
            "DistanceApp",
            Graphics.TEXT_JUSTIFY_CENTER
        );

        dc.drawText(
            width / 2,
            75,
            Graphics.FONT_MEDIUM,
            _status,
            Graphics.TEXT_JUSTIFY_CENTER
        );

        if (_distance != "") {

            dc.drawText(
                width / 2,
                115,
                Graphics.FONT_LARGE,
                _distance,
                Graphics.TEXT_JUSTIFY_CENTER
            );
        }

        dc.drawText(
            width / 2,
            150,
            Graphics.FONT_MEDIUM,
            _speed,
            Graphics.TEXT_JUSTIFY_CENTER
        );
    }


    function updateDisplay(status, distance, speed) as Void {

        _status = status;
        _distance = distance;
        _speed = speed;
        
        if (speed > 0){
            var x = speed * 60 * 60;
            speed = x /1600;
            _speed = speed + " mph";
        }
        WatchUi.requestUpdate();
    }

}