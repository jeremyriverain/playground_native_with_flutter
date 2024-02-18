import Flutter

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
