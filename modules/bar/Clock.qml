import qs.io
import qs.components

BarModule {
    BarItem {
        icon: "schedule"
        text: Qt.formatTime(CurrentTime.date, "hh\nmm")
    }
}
