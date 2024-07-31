import QtQuick 2.9
import QtQuick.Controls
import QtQuick.Controls.Universal

TextField {
    id: root
    required property int minimalValue
    required property int maximalValue
    Universal.theme: appWindow.currentTheme
    Binding {
        target: root
        property: "color"
        when: !acceptableInput
        value: "red"
    }
    font.pixelSize: Math.min(height, width) / 2.6
    horizontalAlignment: TextField.AlignHCenter
    verticalAlignment: TextField.AlignVCenter
    validator: IntValidator{bottom: minimalValue; top: maximalValue}
}