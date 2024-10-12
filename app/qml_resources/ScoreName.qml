import QtQuick 2.9
import QtQuick.Controls
import QtQuick.Controls.Universal

Item {
    property alias text: name.text
    property bool editable: false
    property double reduceFactor: 3
    property double widthForPixelSize: width
    property alias textWidth: name.implicitWidth
    TextField {
        id: name
        anchors.fill: parent
        onFocusChanged: if(!editable) focus = false
        onAccepted: focus = false
        onActiveFocusChanged: if(!activeFocus) focus = false
        selectByMouse: parent.editable
        readOnly: !parent.editable
        background: Item{}
        horizontalAlignment: TextArea.AlignHCenter
        verticalAlignment: TextArea.AlignVCenter
        font.pixelSize: Math.min(parent.height, parent.widthForPixelSize) / parent.reduceFactor
    }
}