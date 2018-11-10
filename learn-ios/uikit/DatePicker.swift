import UIKit

class DatePicker: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let datePickerTime = UIDatePicker(frame:CGRect(x: 0, y: 0, width: 320, height: 200))
        datePickerTime.datePickerMode = .time
        self.view.addSubview(datePickerTime)
        // 设置最大值，最小值
        
        // 设置模式
        let datePickerDate = UIDatePicker(frame: CGRect(x: 0, y: 160, width: 320, height: 200))
        datePickerDate.datePickerMode = .date
        self.view.addSubview(datePickerDate)
        
        let datePickerDateAndTime = UIDatePicker(frame: CGRect(x: 0, y: 320, width: 320, height: 200))
        datePickerDateAndTime.datePickerMode = .dateAndTime
        self.view.addSubview(datePickerDateAndTime)
        
        let datePickerDateCountDownTimer = UIDatePicker(frame: CGRect(x: 0, y: 480, width: 320, height: 200))
        datePickerDateCountDownTimer.datePickerMode = .countDownTimer
        self.view.addSubview(datePickerDateCountDownTimer)
        
        // 修改分钟的步长，默认为1
        datePickerTime.minuteInterval = 15
        
        // 修改倒计算
        datePickerDateCountDownTimer.countDownDuration = 60 * 60
        
        // 监听
        datePickerDate.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        
    }
    
    @objc func dateChange(_ sender:UIDatePicker) {
        print("date:\(sender.date)")
    }
}
