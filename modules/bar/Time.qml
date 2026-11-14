import QtQuick
import qs.io
import qs.components

BarMultiModule {
    id: root

    property bool showDate: false

    MultiModuleComponent {
        BarModule {
            styled: false
            implicitWidth: root.width

            BarItem {
                icon: "schedule"
                text: Qt.formatDateTime(CurrentTime.date, "hh\nmm")
                onClicked: root.showDate = !root.showDate
            }
        }
    }

    MultiModuleComponent {
        condition: root.showDate

        BarModule {
            styled: false
            implicitWidth: root.width

            BarItem {
                icon: "calendar_month"
                text: Qt.formatDateTime(CurrentTime.date, "dd\nMM\nyy")
                onClicked: root.showDate = !root.showDate
            }
        }
    }
}
