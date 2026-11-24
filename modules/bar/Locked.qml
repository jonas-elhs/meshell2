import Quickshell
import qs.components

BarModule {
    id: root

    required property ShellScreen screen

    width: screen.width
    height: screen.height

    alignOnEdge: true
}
