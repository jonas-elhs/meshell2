pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Wayland
import Quickshell.Services.Pam
import qs.io

Item {
    id: root

    property string password: ""
    property bool authenticating: false

    LockWallpaper {}

    PamContext {
        id: pam

        onCompleted: result => {
            root.password = "";
            root.authenticating = false;

            if (result == PamResult.Success) {
                ShellState.locked = false;
                return;
            }
        }

        onPamMessage: {
            if (this.responseRequired) {
                root.authenticating = true;
                this.respond(root.password);
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

                focus: true
                Keys.onPressed: event => {
                    const key = event.key;

                    if (root.authenticating == true)
                        return;

                    if (key === Qt.Key_Enter || key === Qt.Key_Return)
                        pam.start();
                    else if (key === Qt.Key_Escape)
                        root.password = "";
                    else if (key === Qt.Key_Backspace)
                        if (event.modifiers & Qt.ControlModifier)
                            root.password = "";
                        else
                            root.password = root.password.slice(0, -1);
                    else if (!(event.modifiers & (Qt.ControlModifier | Qt.MetaModifier | Qt.AltModifier)) && /^[\x20-\x7E]$/.test(event.text))
                        root.password += event.text;

                    event.accepted = true;
                }

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

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 200

                    text: root.password
                }
            }
        }
    }
}
