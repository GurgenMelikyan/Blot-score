import QtQuick 2.9
import QtQuick.Controls
import QtQuick.Controls.Universal

Item {
    property alias text: name.text
    property double reduceFactor: 3
    TextField {
        id: name
        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }
        onFocusChanged: focus = false
        selectByMouse: false
        readOnly: true
        background: Item{}
        horizontalAlignment: TextArea.AlignHCenter
        verticalAlignment: TextArea.AlignVCenter
        font.pixelSize: Math.min(parent.height, parent.width) / parent.reduceFactor
    }
}