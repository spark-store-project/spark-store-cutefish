import QtQuick 2.12
import QtQml.Models 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

import FishUI 1.0 as FishUI

FishUI.Window {
    id: root
    width: settings.width
    height: settings.height
    minimumWidth: 900
    minimumHeight: 580
    visible: true
    title: qsTr("Spark Store")

    background.opacity: 1
    header.height: 36 + FishUI.Units.largeSpacing

    LayoutMirroring.enabled: Qt.application.layoutDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    property QtObject settings: GlobalSettings { }

    onClosing: {
        if (root.visibility !== Window.Maximized &&
                root.visibility !== Window.FullScreen) {
            settings.width = root.width
            settings.height = root.height
        }
    }

    headerItem: Item {
        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: FishUI.Units.smallSpacing * 1.5
            anchors.rightMargin: FishUI.Units.smallSpacing * 1.5
            anchors.topMargin: FishUI.Units.smallSpacing * 1.5
            anchors.bottomMargin: FishUI.Units.smallSpacing * 1.5

            spacing: FishUI.Units.smallSpacing

            IconButton {
                Layout.fillHeight: true
                implicitWidth: height
                source: FishUI.Theme.darkMode ? "qrc:/images/dark/go-previous.svg"
                                              : "qrc:/images/light/go-previous.svg"
                onClicked: _appListPage.goBack()
            }

            IconButton {
                Layout.fillHeight: true
                implicitWidth: height
                source: FishUI.Theme.darkMode ? "qrc:/images/dark/go-next.svg"
                                              : "qrc:/images/light/go-next.svg"
                onClicked: _appListPage.goForward()
            }

            PathBar {
                id: _pathBar
                Layout.fillWidth: true
                Layout.fillHeight: true
                onItemClicked: _appListPage.openUrl(path)
                onEditorAccepted: _appListPage.openUrl(path)
            }
        }
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        SideBar {
            id: _sideBar
            Layout.fillHeight: true
            width: 180 + FishUI.Units.largeSpacing
            onClicked: _appListPage.openUrl(path)
        }

        AppListPage {
            id: _appListPage
            Layout.fillWidth: true
            Layout.fillHeight: true
            onCurrentUrlChanged: {
                _sideBar.updateSelection(currentUrl)
                _pathBar.updateUrl(currentUrl)
            }
            onRequestPathEditor: {
                _pathBar.openEditor()
            }
        }
    }
}
