import QtQuick

BarModule {
    id: root

    default property list<MultiModuleComponent> modules: []

    readonly property Component defaultModule: modules[0]?.component ?? null
    readonly property Component conditionalModule: modules.find(module => module.condition)?.component ?? null
    readonly property Component module: root.conditionalModule ?? root.defaultModule ?? null

    padding: current.item.padding
    adjustContentSpacing: current.item.adjustContentSpacing
    onScrolled: current.item.onScrolled

    property ModuleLoader current: loader1
    property ModuleLoader next: loader2

    Item {
        implicitWidth: root.current.implicitWidth
        implicitHeight: root.current.implicitHeight

        ModuleLoader {
            id: loader1
        }
        ModuleLoader {
            id: loader2
        }

        Behavior on implicitWidth {
            CustomNumberAnimation {}
        }
        Behavior on implicitHeight {
            CustomNumberAnimation {}
        }
    }

    Component.onCompleted: updateModule()
    onModuleChanged: updateModule()
    function updateModule() {
        current.z = 1;
        current.scale = 0;
        current.opacity = 0;

        next.sourceComponent = root.module;
        next.z = 2;
        next.scale = 1;
        next.opacity = 1;

        [current, next] = [next, current];
    }

    component ModuleLoader: Loader {
        anchors.verticalCenter: parent.verticalCenter

        Behavior on scale {
            CustomNumberAnimation {}
        }
        Behavior on opacity {
            CustomNumberAnimation {}
        }
    }
}
