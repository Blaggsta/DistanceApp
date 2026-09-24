import Toybox.WatchUi;
import Toybox.Position;
import Toybox.Math;
import Toybox.Lang;
import Toybox.Timer;

class DistanceAppDelegate extends WatchUi.BehaviorDelegate {

    private var _view;

    private var _waitingForPoint = false;

    private var _point1Set = false;
    private var _point2Set = false;

    private var _lat1 = null;
    private var _lon1;
    private var _timer1;

    private var _lat2 = null;
    private var _lon2;
    private var _timer2;

    private var totalDistance;
    private var speed = 0;

    private var myTimer;
    private var timer = 0;

    private var currentLat = 0.0;
    private var currentLong = 0.0;


    function initialize(view) {

        BehaviorDelegate.initialize();

        _view = view;

        Position.enableLocationEvents(
            Position.LOCATION_CONTINUOUS,
            method(:onPosition)
        );
        
    }


    function onPosition(info as Position.Info) as Void {

        if (info.position == null) {
            return;
        }

        if (info.accuracy == null) {
            return;
        }

        // Only accept a GOOD GPS fix

        if (info.accuracy != Position.QUALITY_GOOD) {
            return;
        }

        // Don't save anything until UP is pressed
/*
        if (!_waitingForPoint) {
            return;
        }
*/
        var coordinates = info.position.toDegrees();

        var latitude = coordinates[0];
        var longitude = coordinates[1];

        _waitingForPoint = false;

        currentLat = latitude;
        currentLong = longitude;

        // FIRST POINT

        if (_point1Set) {

            _lat1 = latitude;
            _lon1 = longitude;
            _timer1 = timer;

            _point1Set = false;

            _view.updateDisplay(
                "Saved",
                ""
            );

        }


        // SECOND POINT

        if (_point2Set) {

            _lat2 = latitude;
            _lon2 = longitude;
            _timer2 = timer;

            _point2Set = false;

            _view.updateDisplay(
                "Saved",
                ""
            );
            
        }
        
        if (_lat1 != null && _lat2 != null){
            calculateDistance();

            var oneTOme = calculateLocToMe(1);
            var twoTome = calculateLocToMe(2);

            
            _view.updateLoc1ToMe(oneTOme);
            _view.updateLoc2ToMe(twoTome);
        }
        WatchUi.requestUpdate();
    }


    function calculateDistance() as Void {

        var lat1 = Math.toRadians(_lat1);
        var lat2 = Math.toRadians(_lat2);

        var lon1 = Math.toRadians(_lon1);
        var lon2 = Math.toRadians(_lon2);

        var dLat = lat2 - lat1;
        var dLon = lon2 - lon1;


        // Haversine formula

        var a =
            Math.pow(Math.sin(dLat / 2), 2) +
            Math.cos(lat1) *
            Math.cos(lat2) *
            Math.pow(Math.sin(dLon / 2), 2);


        var c = 2 * Math.atan2(
            Math.sqrt(a),
            Math.sqrt(1 - a)
        );


        // Earth radius in metres

        var distance = 6371000 * c;

        var roundedDistance = (distance + 0.5).toNumber();

        totalDistance = roundedDistance;

        var formatted = totalDistance.format("%.0f");

        _view.updateDisplay(
                "Saved",formatted
            );

        
    }
    

    function onPreviousPage() as Boolean {

        // If both points have already been saved,
        // start a new measurement.

        _point1Set = true;


        // Wait for a good GPS fix

        _waitingForPoint = true;

        _view.updateDisplay(
            "Waiting for GPS",
            ""
        );

        return true;
    }

    function onNextPage() as Boolean {
        // If both points have already been saved,
        // start a new measurement.

        _point2Set = true;


        // Wait for a good GPS fix

        _waitingForPoint = true;

        _view.updateDisplay(
            "Waiting for GPS",
            ""
        );

        return true;
    }


    function onBack() as Boolean {

        // Stop GPS before leaving the app

        Position.enableLocationEvents(Position.LOCATION_DISABLE,null);

        // Allow the normal Back action to exit

        return false;
    }

    



    function calculateLocToMe(loc) as Float {
        var locX;
        var locY;
        if (loc == 1){
            locX = _lat1;
            locY = _lon1;
        }else{
            locX = _lat2;
            locY = _lon2;
        }



        var lat1 = Math.toRadians(locX);
        var lat2 = Math.toRadians(currentLat);

        var lon1 = Math.toRadians(locY);
        var lon2 = Math.toRadians(currentLong);

        var dLat = lat2 - lat1;
        var dLon = lon2 - lon1;


        // Haversine formula

        var a =
            Math.pow(Math.sin(dLat / 2), 2) +
            Math.cos(lat1) *
            Math.cos(lat2) *
            Math.pow(Math.sin(dLon / 2), 2);


        var c = 2 * Math.atan2(
            Math.sqrt(a),
            Math.sqrt(1 - a)
        );


        // Earth radius in metres

        var distance = 6371000 * c;

        var roundedDistance = (distance + 0.5).toNumber();

        totalDistance = roundedDistance;

        return distance;
/*
        if (roundedDistance >= 1000) {

            var kilometres = distance / 1000.0;
            return kilometres;

        } else {
            
            return distance;
        }
*/
        
    }


}