import UIKit

class TimerUIApplication: UIApplication {
    
    static let ApplicationDidTimeoutNotification = "AppTimeout"
    
    let timeoutInSeconds: TimeInterval = 2 * 60
    
    var idleTimer: Timer?
    
    func resetIdleTimer() {
        
        if let idleTimer = idleTimer {
            idleTimer.invalidate()
        }
        
        idleTimer = Timer.scheduledTimer(timeInterval: timeoutInSeconds, target: self, selector: #selector(TimerUIApplication.idleTimerExceeded), userInfo: nil, repeats: false)
        
    }
    
    @objc func idleTimerExceeded() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: TimerUIApplication.ApplicationDidTimeoutNotification), object: nil)
    }
    
    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
        
        if idleTimer != nil {
            self.resetIdleTimer()
        }
        
        if let touches = event.allTouches {
            
            for touch in touches {
                if touch.phase == UITouch.Phase.began {
                    self.resetIdleTimer()
                }
            }
            
        }
    }
}
