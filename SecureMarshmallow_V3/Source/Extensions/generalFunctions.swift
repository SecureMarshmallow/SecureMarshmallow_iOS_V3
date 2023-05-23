import Foundation

func removeClocksInPast() {
    let today = Calendar.current.dateComponents([.year, .month, .day], from: Date.init())
    for clock in clocks {
        for date in clock.ringDays {
            if (date < today){
                let indexClock = clocks.firstIndex(where: {$0.id == clock.id})
                let indexDate = clocks[indexClock!].ringDays.firstIndex(where: {$0 == date})
                clocks[indexClock!].ringDays.remove(at: indexDate!)
            }
        }
    }
}

func setRingDays(currentClockIndex: Int) {
    let todaysIndex = Calendar.current.dateComponents([.weekday], from: Date.init()).weekday
    let beginShift = 1 - todaysIndex!
    let beginDate = Date.init().advanced(by: TimeInterval((beginShift * 3600 * 24)))

    for index in 0...1000 {
        let checkIndex = (index % 7)
        let checkDate = toDateComponent(date: beginDate.advanced(by: TimeInterval((index * 3600 * 24))))

        if (clocks[currentClockIndex].selectedDays[checkIndex] == true) {
            if (!clocks[currentClockIndex].ringDays.contains(checkDate)) {
                clocks[currentClockIndex].ringDays.append(checkDate)
            }
        }
    }
}

