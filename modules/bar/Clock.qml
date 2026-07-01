import Quickshell
import qs.components

BarModule {
    BarItem {
        icon: "schedule"
        text: Qt.formatTime(time.date, "hh\nmm")
    }

    SystemClock {
        id: time
        precision: SystemClock.Minutes
    }
}
