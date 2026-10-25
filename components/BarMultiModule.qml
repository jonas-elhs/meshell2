import QtQuick

BarModule {
    id: root

    default property list<MultiModuleComponent> modules: []

    readonly property Component defaultModule: modules[0]?.component ?? null
    readonly property Component conditionalModule: modules.find(module => module.condition)?.component ?? null

    padding: loader.item.padding
    adjustVerticalPadding: loader.item.adjustVerticalPadding
    onScrolled: loader.item.onScrolled

    Loader {
        id: loader

        sourceComponent: root.conditionalModule ?? root.defaultModule ?? null
    }
}
