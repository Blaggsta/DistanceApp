import Toybox.WatchUi;
import Toybox.Graphics;

class DistanceAppView extends WatchUi.View {

    private var _status = "Press UP";
    private var _distance = "";
    private var _speed = "";


    function initialize() {
        View.initialize();
    }


    function onUpdate(dc as Dc) as Void {
        var width = dc.getWidth();
        var height = dc.getHeight();
        var titleY = height * 0.19;
        var statusY = height * 0.42;
        var distanceY = height * 0.64;
        var speedY = height * 0.83;

        dc.setColor(
            Graphics.COLOR_WHITE,
            Graphics.COLOR_BLACK
        );

        dc.clear();


        dc.drawText(
            width / 2,
            titleY,
            Graphics.FONT_MEDIUM,
            "DistanceApp",
            Graphics.TEXT_JUSTIFY_CENTER
        );

        dc.drawText(
            width / 2,
            statusY,
            Graphics.FONT_MEDIUM,
            _status,
            Graphics.TEXT_JUSTIFY_CENTER
        );

        if (_distance != "") {

            dc.drawText(
                width / 2,
                distanceY,
                Graphics.FONT_LARGE,
                _distance,
                Graphics.TEXT_JUSTIFY_CENTER
            );
        }

        dc.drawText(
            width / 2,
            speedY + 7,
            Graphics.FONT_MEDIUM,
            _speed,
            Graphics.TEXT_JUSTIFY_CENTER
        );

        dc.drawText(
            dc.getWidth() * 0.10,
            dc.getHeight() * 0.55,
            Graphics.FONT_SMALL,
            "Loc 1",
            Graphics.TEXT_JUSTIFY_CENTER
        );
        dc.drawText(
            dc.getWidth() * 0.2,
            dc.getHeight() * 0.77,
            Graphics.FONT_SMALL,
            "Loc 2",
            Graphics.TEXT_JUSTIFY_CENTER
        );
    }


    function updateDisplay(status, distance, speed) as Void {

        _status = status;
        _distance = distance;
        _speed = speed;
        /*
        if (speed > 0){
            var x = speed * 60 * 60;
            speed = x /1600;
            _speed = speed + " mph";
        }*/
        //_speed = "";
        WatchUi.requestUpdate();
    }

    function updateDistanceDirection(direction){
        if (direction){
            _speed = "loc1 -> loc2";
        }else{
            _speed = "loc2 -> loc1";
        }

    }

}