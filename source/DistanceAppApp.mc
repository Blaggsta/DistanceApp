import Toybox.Application;
import Toybox.WatchUi;

class DistanceAppApp extends Application.AppBase {

    private var _view;

    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() {
        _view = new DistanceAppView();

        return [
            _view,
            new DistanceAppDelegate(_view)
        ];
    }

    function getView() {
        return _view as DistanceAppView;
    }
}