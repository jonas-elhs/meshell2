pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import Quickshell.Wayland
import Quickshell.Services.Pam
import qs.io

Item {
    id: root

    property string currentText

    PamContext {
        id: pam

        onCompleted: result => {
            if (result == PamResult.Success) {
                ShellState.locked = false;
                return;
            }
        }

        onPamMessage: {
            if (this.responseRequired) {
                this.respond(root.currentText);
            }
        }
    }

    WlSessionLock {
        id: lock

        locked: ShellState.locked

        WlSessionLockSurface {
            color: "transparent"

            Item {
                anchors.fill: parent

                Button {
                    text: "unlock"
                    onClicked: ShellState.locked = false
                }

                Text {
                    text: Qt.formatDateTime(CurrentTime.date, "hh:mm")
                    color: "red"
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pointSize: 90
                }

                TextField {
                    anchors.centerIn: parent
                    focus: true

                    onTextChanged: root.currentText = this.text

                    onAccepted: {
                        pam.start();
                    }
                }
            }
        }
    }
}
