import Toybox.WatchUi;
import Toybox.Graphics;

class DistanceAppView extends WatchUi.View {

    private var _status = "Press UP";
    private var _distance = "";
    //private var _speed = "";
    private var distanceloc2ToMe;
    private var distanceloc1ToMe;
    private var locX1_TO_me;
    private var locX2_TO_me;


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
        //var speedY;
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
        //var speedFont;
        var locFont;

        if (width > 208) {
            // FR235
            titleFont = Graphics.FONT_MEDIUM;
            statusFont = Graphics.FONT_MEDIUM;
            distanceFont = Graphics.FONT_MEDIUM;
            //speedFont = Graphics.FONT_MEDIUM;
            locFont = Graphics.FONT_SMALL;

            titleY = height * 0.17;
            statusY = height * 0.35;
            distanceY = height * 0.65;
            //speedY = height * 0.87;
            loc1Y = height * 0.5;
            loc2Y = height * 0.81;
            loc1X = width * 0.1;
            loc2X = width * 0.2;
            locX1_TO_me = 0;
            locX2_TO_me = 0;

        } else {
            // Smaller screen
            titleFont = Graphics.FONT_SYSTEM_TINY;
            statusFont = Graphics.FONT_SYSTEM_TINY;
            distanceFont = Graphics.FONT_SYSTEM_TINY;
            //speedFont = Graphics.FONT_SYSTEM_TINY;
            locFont = Graphics.FONT_SYSTEM_XTINY;

            titleY = height * 0.19;
            statusY = height * 0.35;
            distanceY = height * 0.62;
            //speedY = height * 0.83;
            loc1Y = height * 0.51;
            loc2Y = height * 0.75;
            loc1X = width * 0.1;
            loc2X = width * 0.22;
            locX1_TO_me = 0;
            locX2_TO_me = 6;

        }

    // Title
        dc.drawText(
            width / 2,
            titleY,
            titleFont,
            "DistanceApp",
            Graphics.TEXT_JUSTIFY_CENTER
        );
    // Status
        dc.drawText(
            width / 2,
            statusY,
            statusFont,
            _status,
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

        dc.drawText(
            (width / 2) + locX1_TO_me,
            loc1Y,
            locFont,
            "to Me  " + distanceloc1ToMe,
            Graphics.TEXT_JUSTIFY_CENTER
        );

        dc.drawText(
            (width / 2) + locX2_TO_me,
            loc2Y,
            locFont,
            "to Me  " + distanceloc2ToMe,
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
    }


    function updateDisplay(status, distance) as Void {

        _status = status;
        _distance = "Loc1 <" + distance + "> Loc2";
        
        WatchUi.requestUpdate();
    }


    function updateLoc1ToMe(distance) as Void {
        var formatted = distance.format("%.0f");
        distanceloc1ToMe = formatted;
        return;

    } 

    function updateLoc2ToMe(distance) as Void {
        var formatted = distance.format("%.0f");
        distanceloc2ToMe = formatted;
        return;
    }  

}