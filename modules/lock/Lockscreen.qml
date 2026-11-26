pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import Quickshell.Wayland
import Quickshell.Services.Pam
import qs.io

Item {
    id: root

    property string currentText

    LockWallpaper {}

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

                HoverHandler {
                    cursorShape: Qt.BlankCursor
                }

                Text {
                    anchors.centerIn: parent

                    text: Qt.formatDateTime(CurrentTime.date, "hh:mm")
                    color: "red"
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: Config.font
                    font.pointSize: 300
                    font.weight: Font.Bold
                    font.letterSpacing: -20
                }

                TextField {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 200
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
