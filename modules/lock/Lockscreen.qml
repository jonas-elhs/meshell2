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

    onPasswordChanged: {
        while (passwordDotModel.count < password.length)
            passwordDotModel.append({});

        while (passwordDotModel.count > password.length)
            passwordDotModel.remove(passwordDotModel.count - 1);
    }

    ListModel {
        id: passwordDotModel
    }

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

                    if (root.authenticating)
                        return;

                    if (key === Qt.Key_Enter || key === Qt.Key_Return) {
                        root.authenticating = true;
                        pam.start();
                    } else if (key === Qt.Key_Escape)
                        root.password = "";
                    else if (key === Qt.Key_Backspace) {
                        if (event.modifiers & Qt.ControlModifier)
                            root.password = "";
                        else if (passwordDotModel.count > 0)
                            root.password = root.password.slice(0, -1);
                    } else if (!(event.modifiers & (Qt.ControlModifier | Qt.MetaModifier | Qt.AltModifier)) && /^[\x20-\x7E]$/.test(event.text))
                        root.password += event.text;

                    event.accepted = true;
                }

                HoverHandler {
                    cursorShape: Qt.BlankCursor
                }

                Text {
                    anchors.centerIn: parent

                    text: Qt.formatDateTime(CurrentTime.date, "hh:mm")
                    color: Config.foregroundColor
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: Config.font
                    font.pointSize: 300
                    font.weight: Font.Bold
                    font.letterSpacing: -20
                }

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 200

                    width: Math.max(dots.width, 10) + 2 * 20
                    height: 8 + 2 * 15
                    radius: width / 2
                    color: "#242933"

                    MaterialIcon {
                        id: icon

                        anchors.centerIn: parent

                        icon: "lock"
                        color: Config.foregroundColor
                        weight: 600
                        font.pointSize: 12
                        opacity: root.password == "" ? 1 : 0

                        CustomNumberBehavior on opacity {}
                    }

                    ListView {
                        id: dots

                        anchors.centerIn: parent
                        width: contentWidth
                        height: 8

                        spacing: 5
                        interactive: false
                        orientation: ListView.Horizontal

                        model: passwordDotModel

                        delegate: Rectangle {
                            width: 8
                            height: width
                            radius: width / 2
                            color: Config.foregroundColor

                            scale: 0
                            opacity: 0
                            Component.onCompleted: {
                                scale = 1;
                                opacity = 1;
                            }

                            CustomNumberBehavior on scale {}
                            CustomNumberBehavior on opacity {}
                        }

                        CustomNumberBehavior on width {}
                    }
                }
            }
        }
    }
}
