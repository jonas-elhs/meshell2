import QtQml
import Quickshell
import qs.components

BarModule {
    id: root

    signal powerMenuToggleRequested

    BarItem {
        icon: "power_settings_new"
        iconWeight: 600

        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: button => {
            if (button == Qt.LeftButton)
                Quickshell.execDetached(["systemctl", "poweroff"]);
            else if (button == Qt.RightButton)
                root.powerMenuToggleRequested();
        }
    }
}
