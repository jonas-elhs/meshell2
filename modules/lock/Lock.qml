pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import Quickshell.Wayland
import Quickshell.Services.Pam
import qs.io

Item {
    id: root

    property bool locked: false
    property string currentText

    PamContext {
        id: pam

        onCompleted: result => {
            if (result == PamResult.Success) {
                root.locked = false;
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

        locked: root.locked

        WlSessionLockSurface {
            color: "transparent"

            Item {
                anchors.fill: parent

                Button {
                    text: "unlock"
                    onClicked: root.locked = false
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
