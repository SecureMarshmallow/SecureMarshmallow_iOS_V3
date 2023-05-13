//
//  Alarm.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/13.
//

import Foundation
import MediaPlayer

struct Alarm: ObjectPropertyReflectable {
    var propertyDictRepresentation: RepresentationType
    
    var date: Date = Date()
    var enabled: Bool = false
    var snoozeEnabled: Bool = false
    var repeatWeekdays: [Int] = []
    var uuid: String = ""
    var mediaID: String = ""
    var mediaLabel: String = "bell"
    var label: String = "Alarm"
    var onSnooze: Bool = false
    
    init(){
        self.propertyDictRepresentation = [:]
    }

    init(date:Date, enabled:Bool, snoozeEnabled:Bool, repeatWeekdays:[Int], uuid:String, mediaID:String, mediaLabel:String, label:String, onSnooze: Bool){
        self.propertyDictRepresentation = [:]
        self.date = date
        self.enabled = enabled
        self.snoozeEnabled = snoozeEnabled
        self.repeatWeekdays = repeatWeekdays
        self.uuid = uuid
        self.mediaID = mediaID
        self.mediaLabel = mediaLabel
        self.label = label
        self.onSnooze = onSnooze
    }
    
    init(_ dict: ObjectPropertyReflectable.RepresentationType) {
        self.propertyDictRepresentation = dict
        date = dict["date"] as! Date
        enabled = dict["enabled"] as! Bool
        snoozeEnabled = dict["snoozeEnabled"] as! Bool
        repeatWeekdays = dict["repeatWeekdays"] as! [Int]
        uuid = dict["uuid"] as! String
        mediaID = dict["mediaID"] as! String
        mediaLabel = dict["mediaLabel"] as! String
        label = dict["label"] as! String
        onSnooze = dict["onSnooze"] as! Bool
    }

    static var propertyCount: Int = 9
}

extension Alarm {
    var formattedTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self.date)
    }
}

class Alarms: Persistable {
    let uf: UserDefaults = UserDefaults.standard
    let pk: String = "myAlarmKey"
    var alarms: [Alarm] = [] {
        didSet{
            persist()
        }
    }
    
    private func getAlarmsDictRepresentation()->[ObjectPropertyReflectable.RepresentationType] {
        return alarms.map {$0.propertyDictRepresentation}
    }
    
    init() {
        alarms = getAlarms()
    }
    
    func persist() {
        uf.set(getAlarmsDictRepresentation(), forKey: pk)
        uf.synchronize()
    }
    
    func unpersist() {
        for key in uf.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
    }
    
    var count: Int {
        return alarms.count
    }
    
    private func getAlarms() -> [Alarm] {
        let array = UserDefaults.standard.array(forKey: pk)
        guard let alarmArray = array else{
            return [Alarm]()
        }
        if let dicts = alarmArray as? [ObjectPropertyReflectable.RepresentationType]{
            if dicts.first?.count == Alarm.propertyCount {
                return dicts.map{Alarm($0)}
            }
        }
        unpersist()
        return [Alarm]()
    }
}
