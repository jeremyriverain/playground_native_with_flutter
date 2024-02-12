import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController

    // Method Channel Demo (battery level)
    let batteryChannel = FlutterMethodChannel(name: "flutter.demo/battery",
                                              binaryMessenger: controller.binaryMessenger)
    batteryChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      guard call.method == "getBatteryLevel" else {
        result(FlutterMethodNotImplemented)
        return
      }
      self.receiveBatteryLevel(result: result)
    })

    // Event Channel Demo (timer)
     let eventChannel = FlutterEventChannel(name: "flutter.demo/timer", binaryMessenger: controller.binaryMessenger)
    eventChannel.setStreamHandler(TimeHandler())

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
  private func receiveBatteryLevel(result: FlutterResult) {
    let device = UIDevice.current
    device.isBatteryMonitoringEnabled = true
    if device.batteryState == UIDevice.BatteryState.unknown {
      result(FlutterError(code: "UNAVAILABLE",
                          message: "Battery level not available.",
                          details: nil))
    } else {
      result(Int(device.batteryLevel * 100))
    }
  }


 class TimeHandler: NSObject, FlutterStreamHandler {
        var timer = Timer()
        private var eventSink: FlutterEventSink?
        
        func onListen(withArguments arguments: Any?, eventSink: @escaping FlutterEventSink) -> FlutterError? {
            self.eventSink = eventSink
    
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                let dateFormat = DateFormatter()
                    dateFormat.dateFormat = "HH:mm:ss"
                    let time = dateFormat.string(from: Date())
                    eventSink(time)
            })
            
        
            return nil
        }
        
        func onCancel(withArguments arguments: Any?) -> FlutterError? {
            eventSink = nil
            return nil
        }
    }
}

