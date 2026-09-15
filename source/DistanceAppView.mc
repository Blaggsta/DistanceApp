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
        System.println(width);
        

        var titleY;
        var statusY;
        var distanceY;
        var speedY;
        var loc1Y;
        var loc2Y;
        var loc1X; 
        var loc2X;

        dc.setColor(
            Graphics.COLOR_WHITE,
            Graphics.COLOR_BLACK
        );

        dc.clear();

        // Choose fonts depending on screen size
        var titleFont;
        var statusFont;
        var distanceFont;
        var speedFont;
        var locFont;

        if (width > 208) {
            // FR235
            titleFont = Graphics.FONT_MEDIUM;
            statusFont = Graphics.FONT_MEDIUM;
            distanceFont = Graphics.FONT_LARGE;
            speedFont = Graphics.FONT_MEDIUM;
            locFont = Graphics.FONT_SMALL;

            titleY = height * 0.19;
            statusY = height * 0.42;
            distanceY = height * 0.64;
            speedY = height * 0.87;
            loc1Y = height * 0.55;
            loc2Y = height * 0.77;
            loc1X = width * 0.1;
            loc2X = width * 0.2;

        } else {
            // Smaller screen
            titleFont = Graphics.FONT_SYSTEM_TINY;
            statusFont = Graphics.FONT_SYSTEM_TINY;
            distanceFont = Graphics.FONT_SYSTEM_SMALL;
            speedFont = Graphics.FONT_SYSTEM_TINY;
            locFont = Graphics.FONT_SYSTEM_XTINY;

            titleY = height * 0.19;
            statusY = height * 0.42;
            distanceY = height * 0.64;
            speedY = height * 0.83;
            loc1Y = height * 0.51;
            loc2Y = height * 0.73;
            loc1X = width * 0.1;
            loc2X = width * 0.2;
        }


        dc.drawText(
            width / 2,
            titleY,
            titleFont,
            "DistanceApp",
            Graphics.TEXT_JUSTIFY_CENTER
        );

        dc.drawText(
            width / 2,
            statusY,
            statusFont,
            _status,
            Graphics.TEXT_JUSTIFY_CENTER
        );

        if (_distance != "") {

            dc.drawText(
                width / 2,
                distanceY,
                distanceFont,
                _distance,
                Graphics.TEXT_JUSTIFY_CENTER
            );
        }

        dc.drawText(
            width / 2,
            speedY,
            speedFont,
            _speed,
            Graphics.TEXT_JUSTIFY_CENTER
        );


        dc.drawText(
            loc1X,
            loc1Y,
            locFont,
            "Loc 1",
            Graphics.TEXT_JUSTIFY_CENTER
        );

        dc.drawText(
            loc2X,
            loc2Y,
            locFont,
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