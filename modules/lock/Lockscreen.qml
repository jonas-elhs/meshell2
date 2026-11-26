pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Wayland
import Quickshell.Services.Pam
import qs.io
import qs.components

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
                    else if (key === Qt.Key_Escape) {
                        root.password = "";
                        passwordDotModel.clear();
                    } else if (key === Qt.Key_Backspace) {
                        if (event.modifiers & Qt.ControlModifier) {
                            root.password = "";
                            passwordDotModel.clear();
                        } else {
                            root.password = root.password.slice(0, -1);
                            passwordDotModel.remove(passwordDotModel.count - 1);
                        }
                    } else if (!(event.modifiers & (Qt.ControlModifier | Qt.MetaModifier | Qt.AltModifier)) && /^[\x20-\x7E]$/.test(event.text)) {
                        root.password += event.text;
                        passwordDotModel.append({});
                    }

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

                Item {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 200
                    width: dots.width

                    ListView {
                        id: dots

                        anchors.horizontalCenter: parent.horizontalCenter
                        width: contentWidth
                        height: contentHeight

                        spacing: 5
                        interactive: false
                        orientation: ListView.Horizontal

                        model: ListModel {
                            id: passwordDotModel
                        }

                        delegate: Rectangle {
                            width: 10
                            height: width
                            radius: width / 2
                            color: "red"
                            opacity: 0

                            Component.onCompleted: opacity = 1

                            CustomNumberBehavior on opacity {}
                        }

                        CustomNumberBehavior on width {}
                    }
                }
            }
        }
    }
}
