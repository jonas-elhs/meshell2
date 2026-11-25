import QtQuick

BarModule {
    id: root

    default property list<MultiModuleComponent> modules: []

    readonly property Component defaultModule: modules[0]?.component ?? null
    readonly property Component conditionalModule: modules.find(module => module.condition)?.component ?? null
    readonly property Component module: root.conditionalModule ?? root.defaultModule ?? null

    implicitWidth: content.implicitWidth

    padding: current.item.padding
    alignOnEdge: current.item.alignOnEdge
    showWhenLocked: current.item.showWhenLocked
    adjustContentSpacing: current.item.adjustContentSpacing
    onScrolled: event => current.item.onScrolled(event)

    property ModuleLoader current: loader1
    property ModuleLoader next: loader2

    Item {
        id: content

        implicitWidth: root.current.implicitWidth
        implicitHeight: root.current.implicitHeight

        ModuleLoader {
            id: loader1
        }
        ModuleLoader {
            id: loader2
        }

        CustomNumberBehavior on implicitWidth {}
        CustomNumberBehavior on implicitHeight {}
    }

    Component.onCompleted: updateModule()
    onModuleChanged: updateModule()
    function updateModule() {
        current.z = 1;
        current.scale = 0;
        current.opacity = 0;

        next.sourceComponent = null;
        next.sourceComponent = root.module;
        next.z = 2;
        next.scale = 1;
        next.opacity = 1;

        [current, next] = [next, current];
    }

    CustomNumberBehavior on x {}

    component ModuleLoader: Loader {
        anchors.verticalCenter: parent.verticalCenter

        CustomNumberBehavior on scale {}
        CustomNumberBehavior on opacity {}
    }
}
