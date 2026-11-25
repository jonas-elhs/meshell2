import Quickshell
import qs.io
import qs.components

BarModule {
    id: root

    required property ShellScreen screen

    implicitWidth: screen.width + 2 * Config.borderWidth
    implicitHeight: screen.height + 2 * Config.borderWidth

    padding: 0
    borderRadius: 0
    leftMargin: -Config.spacing - Config.borderWidth
    showWhenLocked: true
}
