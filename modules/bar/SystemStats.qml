import Quickshell
import Quickshell.Io
import qs.components

BarModule {
    id: root

    property int cpu: 0
    property int gpu: 0
    property int ram: 0
    property int disk: 0

    horizontalPadding: 0

    BarItem {
        icon: "memory"
        text: root.cpu + "%"
    }
    BarItem {
        icon: "󰢮"
        text: root.gpu + "%"
    }
    BarItem {
        icon: "memory_alt"
        text: root.ram + "%"
    }
    BarItem {
        icon: "hard_drive"
        text: root.disk + "%"
    }

    Process {
        id: process

        command: [Quickshell.shellDir + "/scripts/system_stats.py"]
        running: true

        stdout: StdioCollector {
            waitForEnd: false

            onTextChanged: {
                const lines = this.text.trim().split("\n");
                const values = lines[lines.length - 1].split(";");

                root.cpu = Number(values[0]);
                root.gpu = Number(values[1]);
                root.ram = Number(values[2]);
                root.disk = Number(values[3]);
            }
        }
    }
}
