import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtPositioning
import CyberTracker

ColumnLayout {
    id: root

    property string recordUid
    property string fieldUid
    property var params

    property string collectRecordUid: form.getGlobal("collectRecordUid", root.recordUid)
    property bool canEdit: form.getGlobal("canEdit", false)
    property bool editing: form.getGlobal("editing", false)

    PositionSource {
        id: positionSource
        active: true
        name: App.positionInfoSourceName
        updateInterval: 1000
    }

    SightingListModel {
        id: sightingListModel
    }

    spacing: 0

    // Header.
    Rectangle {
        id: h
        Layout.fillWidth: true

        property string textColor: Utils.lightness(Material.primary) < 130 ? "white" : "black"
        color: Material.primary
        height: Math.max(toolbarInternal.implicitHeight, titleRow.implicitHeight) + App.scaleByFontSize(4)

        ToolBar {
            id: toolbarInternal
            visible: false
        }

        RowLayout {
            width: parent.width
            height: parent.height
            spacing: 0
            visible: root.editing

            ToolButton {
                Layout.alignment: Qt.AlignVCenter
                icon.source: Style.cancelIconSource
                icon.width: Style.toolButtonSize
                icon.height: Style.toolButtonSize
                icon.color: h.textColor
                onClicked: {
                    root.cancelEdit()
                }
            }

            Label {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                Layout.fillWidth: true
                font.pixelSize: App.settings.font20
                horizontalAlignment: Qt.AlignHCenter
                clip: true
                color: h.textColor
                text: form.getFieldDisplayValue(root.recordUid, "mission_id") + " (edit)"
            }

            ToolButton {
                Layout.alignment: Qt.AlignVCenter
                icon.source: Style.okIconSource
                icon.width: Style.toolButtonSize
                icon.height: Style.toolButtonSize
                icon.color: h.textColor
                onClicked: {
                    root.confirmEdit()
                }
            }
        }

        RowLayout {
            width: parent.width
            spacing: 0
            visible: !root.editing

            RowLayout {
                Layout.preferredWidth: Style.toolButtonSize * 4
                Layout.maximumWidth: Style.toolButtonSize * 4
                Layout.alignment: Qt.AlignVCenter
                Layout.fillHeight: true
                spacing: 0

                ToolButton {
                    icon.source: Style.homeIconSource
                    icon.width: Style.toolButtonSize
                    icon.height: Style.toolButtonSize
                    icon.color: h.textColor
                    onClicked: {
                        form.popPagesToParent()
                    }
                }

                ToolButton {
                    icon.source: App.locationLogger.stateIcon
                    icon.width: Style.toolButtonSize
                    icon.height: Style.toolButtonSize
                    icon.color: h.textColor
                    onClicked: {
                        App.showToast(form.trackStreamer.rateFullText)
                    }
                }

                ToolButton {
                    icon.source: "qrc:/icons/map_outline.svg"
                    icon.width: Style.toolButtonSize
                    icon.height: Style.toolButtonSize
                    icon.color: h.textColor
                    onClicked: {
                        form.pushPage("qrc:/MapsPage.qml")
                    }
                }

                ToolButton {
                    icon.source: "qrc:/icons/settings_outline.svg"
                    icon.width: Style.toolButtonSize
                    icon.height: Style.toolButtonSize
                    icon.color: h.textColor
                    onClicked: {
                        popup.open()
                    }
                }

            }

            Label {
                id: titleRow
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                Layout.fillWidth: true
                font.pixelSize: App.settings.font20
                horizontalAlignment: Qt.AlignHCenter
                clip: true
                color: h.textColor
                text: form.getFieldDisplayValue(root.recordUid, "mission_id")
            }

            RowLayout {
                Layout.preferredWidth: Style.toolButtonSize * 4
                Layout.maximumWidth: Style.toolButtonSize * 4
                Layout.alignment: Qt.AlignVCenter
                Layout.fillHeight: true
                spacing: 0

                RoundButton {
                    id: stopButton
                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillWidth: true
                    text: "Stop survey"
                    font.pixelSize: App.settings.font12
                    radius: App.scaleByFontSize(4)
                    onClicked: {
                        let recordUid = form.getGlobal("collectRecordUid", root.recordUid)
                        let lastLocation = App.lastLocation.toMap

                        // Finalize the track.
                        form.pushTrackLocation(lastLocation)
                        form.snapTrack()
                        form.project.locationStreamingEnabled = false

                        // Create stop sighting.
                        form.setFieldValue(recordUid, "location", lastLocation)
                        form.setFieldValue(recordUid, "datetime", App.timeManager.currentDateTimeISO())
                        form.setFieldValue(recordUid, "type", "Stop")
                        form.resetFieldValue(recordUid, "observation_category")
                        form.resetFieldValue(recordUid, "observation_type")
                        form.resetFieldValue(recordUid, "measure_type")
                        form.resetFieldValue(recordUid, "measure")
                        form.resetFieldValue(recordUid, "in_out")
                        form.resetFieldValue(recordUid, "direction")
                        form.saveSighting()
                        form.markSightingCompleted()

                        // Reset.
                        form.newSighting()
                        form.wizard.init(form.rootRecordUid)
                        form.setGlobal("collectRecordUid", undefined)
                        form.saveState()
                        form.loadPages()
                    }
                }
            }
        }
    }

    // Content.
    // Field bindings.
    FieldBinding {
        id: bindLocation
        recordUid: root.collectRecordUid
        fieldUid: "location"
    }

    FieldBinding {
        id: bindProtocol
        recordUid: root.collectRecordUid
        fieldUid: "protocol"
    }

    FieldBinding {
        id: bindCategory
        recordUid: root.collectRecordUid
        fieldUid: "observation_category"
    }

    FieldBinding {
        id: bindType
        recordUid: root.collectRecordUid
        fieldUid: "observation_type"
    }

    FieldBinding {
        id: bindMeasureType
        recordUid: root.collectRecordUid
        fieldUid: "measure_type"
    }

    FieldBinding {
        id: bindMeasure
        recordUid: root.collectRecordUid
        fieldUid: "measure"
    }

    FieldBinding {
        id: bindInOut
        recordUid: root.collectRecordUid
        fieldUid: "in_out"
    }

    FieldBinding {
        id: bindDirection
        recordUid: root.collectRecordUid
        fieldUid: "direction"
    }

    // Models.
    ElementListModel {
        id: modelCategory
        Component.onCompleted: {
            elementUid = bindCategory.field.listElementUid
        }
    }

    ElementListModel {
        id: modelType
        Component.onCompleted: {
            elementUid = bindType.field.listElementUid
        }
    }

    ElementListModel {
        id: modelMeasureType
        Component.onCompleted: {
            elementUid = bindMeasureType.field.listElementUid
        }
    }

    ElementListModel {
        id: modelInOut
        Component.onCompleted: {
            elementUid = bindInOut.field.listElementUid
        }
    }

    ElementListModel {
        id: modelDirection
        Component.onCompleted: {
            elementUid = bindDirection.field.listElementUid
        }
    }

    Item { height: App.scaleByFontSize(2) }

    Label {
        id: labelTitle
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        font.pixelSize: App.settings.font20
        font.bold: true
        text: getTitle()
    }

    Item { height: App.scaleByFontSize(2) }

    Rectangle {
        width: parent.width
        height: Style.lineWidth1
        color: Style.colorGroove
    }

    RowLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        spacing: 0

        FieldGridView {
            id: gridCategory
            Layout.fillHeight: true
            Layout.preferredWidth: App.scaleByFontSize(52)
            opacity: 0.5
            topMargin: -Style.lineWidth1
            recordUid: root.collectRecordUid
            fieldUid: "observation_category"
            params: ({ columns: 1, lines: true, style: "IconOnly", itemHeight: App.scaleByFontSize(52) })
            onItemClicked: (elementUid) => {
                bindCategory.setValue(elementUid)
                let listElementUid = gridType.model.elementUid
                gridType.model.elementUid = ""
                gridType.model.elementUid = listElementUid
                updateTitle()
            }
        }

        FieldGridView {
            id: gridType
            Layout.fillWidth: true
            Layout.fillHeight: true
            recordUid: root.collectRecordUid
            fieldUid: "observation_type"
            params: updateParams()

            onItemClicked: (elementUid) => {
                // Do not set the location for edited sightings.
                if (!root.editing) {
                    bindLocation.setValue(App.lastLocation.toMap)
                }

                bindType.setValue(elementUid)
                updateTitle()
            }
        }

        ColumnLayout {
            Layout.maximumWidth: App.scaleByFontSize(52) * 3
            Layout.fillHeight: true
            spacing: 0

            Row {
                Layout.fillWidth: true
                spacing: 0

                ButtonGroup {
                    id: buttonGroupMeasureType
                }

                Rectangle {
                    visible: bindProtocol.value === "protocol/recce"
                    width: parent.width
                    height: editButton.height
                    Material.background: "transparent"
                    Material.roundedScale: Material.NotRounded
                    enabled: false
                    color: "transparent"

                    Text {
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: form.getElementName("measure_type/count")
                        font.pixelSize: App.settings.font14
                    }
                }

                Repeater {
                    id: measureType
                    model: modelMeasureType
                    visible: bindProtocol.value !== "protocol/recce"

                    Button {
                        width: parent.width / modelMeasureType.count
                        ButtonGroup.group: buttonGroupMeasureType
                        Material.background: checked ? Material.accent : "transparent"
                        Material.roundedScale: Material.NotRounded

                        contentItem: Text {
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            text: form.getElementName(modelData.uid)
                            color: parent.checked ? "white" : "black"
                            font.pixelSize: App.settings.font14
                            font.bold: parent.checked
                        }
                        checked: bindMeasureType.value === modelData.uid
                        onClicked: {
                            bindMeasureType.setValue(modelData.uid)
                        }
                    }
                }
            }

            FieldKeypad {
                id: keypad
                Layout.fillWidth: true
                height: App.scaleByFontSize(52) * 4
                recordUid: root.collectRecordUid
                fieldUid: "measure"
            }

            Row {
                Layout.fillWidth: true
                spacing: 0
                visible: bindProtocol.value === "protocol/sample"

                ButtonGroup {
                    id: buttonGroupInOut
                }

                Repeater {
                    model: modelInOut

                    Button {
                        width: parent.width / modelInOut.count
                        ButtonGroup.group: buttonGroupInOut
                        Material.background: checked ? Material.accent : "transparent"
                        Material.roundedScale: Material.NotRounded
                        checkable: true
                        contentItem: Text {
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            text: form.getElementName(modelData.uid)
                            color: parent.checked ? "white" : "black"
                            font.pixelSize: App.settings.font14
                            font.bold: parent.checked
                        }
                        checked: bindInOut.value === modelData.uid
                        onClicked: {
                            bindInOut.setValue(modelData.uid)
                        }
                    }
                }
            }

            Row {
                Layout.fillWidth: true

                ButtonGroup {
                    id: buttonGroupDirection
                }

                Repeater {
                    model: modelDirection

                    Button {
                        width: parent.width / modelDirection.count
                        ButtonGroup.group: buttonGroupDirection
                        Material.background: checked ? Material.accent : "transparent"
                        Material.roundedScale: Material.NotRounded
                        checkable: true
                        contentItem: Text {
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            text: form.getElementName(modelData.uid)
                            color: parent.checked ? "white" : "black"
                            font.pixelSize: App.settings.font14
                            font.bold: parent.checked
                        }
                        checked: bindDirection.value === modelData.uid
                        onClicked: {
                            bindDirection.setValue(modelData.uid)

                            if (!root.editing) {
                                root.saveSighting()
                            }
                        }
                    }
                }
            }

            Item {
                Layout.fillHeight: true
            }

            Button {
                id: editButton
                Layout.fillWidth: true
                Material.roundedScale: Material.NotRounded
                Material.background: Material.Red
                visible: root.canEdit && !root.editing
                contentItem: Text {
                    width: parent.width
                    horizontalAlignment: Qt.AlignHCenter
                    font.pixelSize: App.settings.font14
                    text: "Edit last"
                    color: "white"
                }

                onClicked: {
                    root.startEdit()
                }
            }
        }
    }

    PopupBase {
        id: popup

        //width: parent.width * 0.75

        contentItem: ColumnLayout {
            //width: popup.width
            spacing: 0

            Component.onCompleted: {
                setProjectColors(popup)
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 0

                Label {
                    text: "Columns"
                    font.pixelSize: App.settings.font14
                    clip: true
                }

                Item {
                    Layout.fillWidth: true
                    Layout.minimumWidth: App.scaleByFontSize(32)
                }

                Label {
                    font.pixelSize: App.settings.font14
                    text: getColumnCount()
                    opacity: 0.5
                }

                ToolButton {
                    icon.source: "qrc:/icons/minus.svg"
                    icon.width: Style.toolButtonSize / 2
                    icon.height: Style.toolButtonSize / 2
                    opacity: 0.5
                    onClicked: {
                        setColumnCount(-1)
                    }
                }

                ToolButton {
                    icon.source: "qrc:/icons/plus.svg"
                    icon.width: Style.toolButtonSize / 2
                    icon.height: Style.toolButtonSize / 2
                    opacity: 0.5
                    onClicked: {
                        setColumnCount(1)
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 0

                Label {
                    text: "Icon size"
                    font.pixelSize: App.settings.font14
                    clip: true
                }

                Item {
                    Layout.fillWidth: true
                    Layout.minimumWidth: App.scaleByFontSize(32)
                }

                Label {
                    font.pixelSize: App.settings.font14
                    text: getIconSize()
                    opacity: 0.5
                }

                ToolButton {
                    icon.source: "qrc:/icons/minus.svg"
                    icon.width: Style.toolButtonSize / 2
                    icon.height: Style.toolButtonSize / 2
                    opacity: 0.5
                    onClicked: {
                        setIconSize(-1)
                    }
                }

                ToolButton {
                    icon.source: "qrc:/icons/plus.svg"
                    icon.width: Style.toolButtonSize / 2
                    icon.height: Style.toolButtonSize / 2
                    opacity: 0.5
                    onClicked: {
                        setIconSize(1)
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 0

                Label {
                    text: "Padding"
                    font.pixelSize: App.settings.font14
                    clip: true
                }

                Item {
                    Layout.fillWidth: true
                    Layout.minimumWidth: App.scaleByFontSize(32)
                }

                Label {
                    font.pixelSize: App.settings.font14
                    text: getPadding()
                    opacity: 0.5
                }

                ToolButton {
                    icon.source: "qrc:/icons/minus.svg"
                    icon.width: Style.toolButtonSize / 2
                    icon.height: Style.toolButtonSize / 2
                    opacity: 0.5
                    onClicked: {
                        setPadding(-1)
                    }
                }

                ToolButton {
                    icon.source: "qrc:/icons/plus.svg"
                    icon.width: Style.toolButtonSize / 2
                    icon.height: Style.toolButtonSize / 2
                    opacity: 0.5
                    onClicked: {
                        setPadding(1)
                    }
                }
            }
        }
    }

    function getTitle() {
        let elementUid = bindType.value
        if (elementUid === undefined) {
            elementUid = bindCategory.value
        }

        return elementUid === undefined ? "Ready!" : form.getElementName(elementUid)
    }

    function updateTitle() {
        labelTitle.text = getTitle()
    }

    function getColumnCount() {
        return form.getGlobal("columns", root.params.columns === undefined ? 4 : root.params.columns)
    }

    function setColumnCount(delta) {
        let columns = getColumnCount() + delta

        if (columns < 3) {
            columns = 3
        } else if (columns > 12) {
            columns = 12
        }

        form.setGlobal("columns", columns)

        root.params = updateParams()
    }

    function getIconSize() {
        return form.getGlobal("itemHeight", root.params.itemHeight === undefined ? 32 : root.params.itemHeight)
    }

    function setIconSize(delta) {

        let itemHeight = getIconSize() + delta

        if (itemHeight < 32) {
            itemHeight = 32
        } else if (itemHeight > 256) {
            itemHeight = 256
        }

        form.setGlobal("itemHeight", itemHeight)

        root.params = updateParams()
    }

    function getPadding() {
        return form.getGlobal("padding", root.params.padding === undefined ? 4 : root.params.padding)
    }

    function setPadding(delta) {
        let padding = getPadding() + delta

        if (padding < 0) {
            padding = 0
        } else if (padding > 256) {
            padding = 256
        }

        form.setGlobal("padding", padding)

        root.params = updateParams()
    }

    function updateParams() {
        let result = root.params
        result.columns = getColumnCount()
        result.itemHeight = getIconSize()
        result.padding = getPadding()

        return result
    }

    function newSighting() {
        let fieldUids = ["location", "observation_type", "measure_type", "measure", "in_out", "direction"]
        for (let i = 0; i < fieldUids.length; i++) {
            form.resetFieldValue(form.rootRecordUid, fieldUids[i])
        }

        form.newSighting(true)
        form.setGlobal("collectRecordUid", form.rootRecordUid)
        form.setGlobal("editing", false)

        form.loadPages()
        form.saveState()
    }

    function saveSighting() {
        // Recce type must be a count.
        if (bindProtocol.value === "protocol/recce") {
            bindMeasureType.setValue("measure_type/count")
        }

        // Ensure record is valid.
        let errorMessage = ""
        if (!form.getRecordValid(root.collectRecordUid)) {
            errorMessage = "Not complete"
        } else if (bindCategory.isEmpty) {
            errorMessage = "No category"
        } else if (bindType.isEmpty) {
            errorMessage = "No type"
        } else if (bindMeasureType.isEmpty) {
            errorMessage = "No measure type"
        } else if (bindMeasure.isEmpty) {
            errorMessage = "No measure"
        } else if (bindInOut.isEmpty && bindProtocol.value === "protocol/sample") {
            errorMessage = "No in/out specified"
        } else if (bindDirection.isEmpty) {
            errorMessage = "No direction specified"
        }

        if (errorMessage !== "") {
            bindDirection.resetValue()
            App.showError(errorMessage)
            return
        }

        // Save sighting.
        form.setFieldValue(root.collectRecordUid, "datetime", App.timeManager.currentDateTimeISO())
        form.setFieldValue(root.collectRecordUid, "type", "")
        form.saveSighting()
        form.markSightingCompleted()

        // Specify that editing is now allowed.
        form.setGlobal("canEdit", true)

        // New sighting.
        newSighting()
    }

    function startEdit() {
        if (!form.getGlobal("canEdit", false)) {
            App.showError("No editable data")
            return
        }

        let sightingUid = sightingListModel.get(sightingListModel.count - 1).sightingUid
        form.setGlobal("collectRecordUid", sightingUid)
        form.setGlobal("editing", true)

        form.loadSighting(sightingUid)
        form.loadPages()

        form.saveState()
    }

    function cancelEdit() {
        newSighting()
    }

    function confirmEdit() {
        form.saveSighting()
        form.setGlobal("editing", false)
        newSighting()
    }
}
